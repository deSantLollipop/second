class Admin::CommentsController < Admin::ApplicationController
  # http_basic_authenticate_with name: "admin", password: "adminchik",
  #                             except: [:create]
  before_action :authenticate_user!

  def destroy
    @post = Post.find(params[:id])
    @comment = @post.comments.find(params[:post_id])
    @comment.destroy
    redirect_to admin_post_url, notice: 'Comment was deleted by admin.'
  end

  private

  def comment_params
    params.require(:comment).permit(:username, :body)
  end
end
