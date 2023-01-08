class User::PostsController < ApplicationController
  def show
  end

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    post.save
    redirect_to 'user_post_path'
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:post)
  end
end
