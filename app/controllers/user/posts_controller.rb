class User::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @posts = Post.new
    @user = @post.user
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    redirect_to user_post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to user_post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path
  end

  private
  def post_params
    params.require(:post).permit(:body)
  end
end
