class Admin::UsersController < ApplicationController
  def index
    @users = User.all
    p "hoge"
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @post = Post.new
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end
