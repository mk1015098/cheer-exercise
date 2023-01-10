class User::PostCommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = @post.id
    comment.save
    @post_comment = PostComment.new
    redirect_to user_post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.find_by(id: params[:id], post_id: params[:post_id])
    @post_comment.destroy
    @post_comment = PostComment.new
    redirect_to user_post_path(@post.id)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
