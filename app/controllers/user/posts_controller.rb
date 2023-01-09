class User::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @posts = Post.new
  end

  def index
    @posts = Post.all
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
    redirect_to user_post_path(current_user)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:body)
  end
end
