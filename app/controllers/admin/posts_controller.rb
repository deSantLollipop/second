class Admin::PostsController < Admin::ApplicationController
  # http_basic_authenticate_with name: "admin", password: "adminchik",
  #                             except: [:index, :show]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", template: "posts/show.html.erb"
      end
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to admin_post_path, notice: 'Post was updated by admin.'
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    # authorize @post
    @post.destroy
    redirect_to tools_path, notice: 'Post was successfully deleted by admin'
  end

  /def create
    # render plain: params[:post].inspect
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      #  @post.save
      redirect_to @post, notice: 'Post was created by admin.'
    else
      render 'new'
    end
  end/

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
