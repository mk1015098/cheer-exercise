class User::PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @posts = Post.new
    @post_tags = @post.tags
    @user = @post.user
    @post_comment = PostComment.new
  end

  def index
    @posts = Post.all
    @tag_list=Tag.all
    @post = Post.new
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_tag(@tag_list)
    redirect_to user_post_path(@post)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
    if @post.update(post_params)
      if params[:post][:status]
        @old_relations = PostTag.where(post_id: @post.id)
        @old_relations.each do |relation|
          relation.delete
        end
        @post.save_tag(tag_list)
        redirect_to user_post_path(@post)
      else redirect_to user_posts_path
      end
    else render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_posts_path
  end

    def favorites
      @user = User.find(params[:id])
      favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
      @favorite_posts = Post.find(favorites)
    end

  private

  def post_params
    params.require(:post).permit(:body, :tag)
  end
end
