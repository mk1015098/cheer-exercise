class User::FavoritesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @post_favorite = Favorite.new(post_id: params[:post_id])
    @post_favorite.user_id = current_user.id
    @post_favorite.save
    #redirect_to user_post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_favorite = Favorite.find_by(post_id: params[:post_id])
    @post_favorite.destroy
    #redirect_to user_post_path(@post.id)
  end

end
