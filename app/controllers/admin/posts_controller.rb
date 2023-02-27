class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.page(params[:page])
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @user = @post.user
    @post_comment = PostComment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
end
