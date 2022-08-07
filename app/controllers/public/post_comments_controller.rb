class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comments_params)
    comment.post_id = post.id
    comment.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = cuurennt_user.post_comments.find(params[:post_id])
    comment.post_id = post.id
    comment.destroy
    redirect_to request.referer
  end


  private

  def post_comments_params
    params.require(:post_comment).permit(:comment)
  end
end
