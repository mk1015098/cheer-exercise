class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @user = @post.user
    @post_comment = PostComment.new
  end
end
