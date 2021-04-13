class Admin::CommentsController < Admin::ApplicationController
  #http_basic_authenticate_with name: "admin", password: "adminchik",
  #                             except: [:create]
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.username = current_user.email
    if @comment.save
     redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @comment = @post.comments.find(params[:post_id])
    @comment.destroy
   redirect_to post_url
  end

  private def comment_params
    params.require(:comment).permit(:username, :body)
  end

end