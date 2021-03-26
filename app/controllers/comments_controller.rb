class CommentsController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "adminchik",
                               except: [:create]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def destroy
    @comment = Comment.find(params[:post_id])
    @comment.destroy
   redirect_to post_url
  end

  private def comment_params
    params.require(:comment).permit(:username, :body)
  end

end
