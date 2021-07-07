module Api
  module V1
    class CommentsController < ApplicationController
    # http_basic_authenticate_with name: "admin", password: "adminchik",
    #                             except: [:create]
    before_action :authenticate_user!

      def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.create(comment_params)
        @comment.username = current_user.email
        redirect_to post_path(@post), notice: 'Your comment created' if @comment.save
      end

      def destroy
        @post = Post.find(params[:id])
        @comment = @post.comments.find(params[:post_id])
        @comment.destroy
        redirect_to post_url, notice: 'Your comment deleted'
      end

      private

      def comment_params
       params.require(:comment).permit(:username, :body)
      end
    end
  end
end
