class Admin::PostCommentsController < ApplicationController

  def destroy
    @post = Post.find(params[:id])
    @post_comment = PostComment.find_by(params[:id], post_id: params[:post_id])
    @post_comment.destroy
    redirect_to admin_post_path(@post.id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
