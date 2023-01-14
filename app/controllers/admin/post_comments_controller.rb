class Admin::PostCommentsController < ApplicationController

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @post_comment.destroy
    redirect_to admin_post_path(@post.id)
  end

end
