class PostsController < ApplicationController
  # http_basic_authenticate_with name: "admin", password: "adminchik",
  #                             except: [:index, :show]
  before_action :authenticate_user!, except: %i[index show]

  after_action :authorize_post, except: %i[index show destroy]

  def index
    policies = policy_scope(Post)
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id]) # current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: 'Your post was updated.'
    else
      render 'edit'
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render 'new', notice: 'Your post was created.'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post
    @post.destroy
    redirect_to home_path, notice: 'Your post was deleted.'
  end

  def authorize_post
    authorize @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
