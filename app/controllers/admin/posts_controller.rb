class Admin::PostsController < Admin::ApplicationController
  # http_basic_authenticate_with name: "admin", password: "adminchik",
  #                             except: [:index, :show]
  before_action :authenticate_user!, except: %i[index show worker]
  #protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

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


  def worker
   @post = Post.find(params[:id])

                                 #post_path(@post) /2
                                 #post_url(@post) /localhost/posts/2
   job_id = HardWorker.perform_async(@post.id)
   #               .new.perform(@post.id) - perform now

   session[:passed_variable] = job_id

   status = Sidekiq::Status::status(job_id)
   total = Sidekiq::Status::total(job_id)

   url=worker_status_post_path(@post)

   respond_to do |format|
      msg = { :status => status.to_s, :total => total.to_s, :job_id => job_id, :message => "started", :url => url , :html => "<b>...</b>" }
      format.json  { render :json => msg }
      format.html
   end
  end

  def worker_status

    @post = Post.find(params[:id])

    job_id = session[:passed_variable]

    status = Sidekiq::Status::status(job_id)
    total = Sidekiq::Status::total(job_id)

    url = pdf_path(@post)

    respond_to do |format|
      msg = { :status => status.to_s, :total => total.to_s, :job => job_id, :message => "in process", :url => url , :html => "<b>...</b>" }
      format.json  { render :json => msg }
      format.html
    end

  end

  def pdf
    pdf_name = 'post_'+ params[:id].to_s
    pdf_url = Rails.root.join("public", "assets", pdf_name)

    respond_to do |format|
      msg = { :message => "pdf url", :pdf_name => pdf_name, :pdf_url => pdf_url, :url => download_post_path, :html => "<b>...</b>" }
      format.json  { render :json => msg }
      format.html
    end
  end

  def download
    pdf_name = params[:pdf_name]+'.pdf'
    pdf_url = Rails.root.join("public", "assets", pdf_name)
    File.open(pdf_url, 'r') do |f|
      send_data f.read.force_encoding('BINARY'), :filename => params[:pdf_name], :type => "application/pdf", :disposition => "inline"
    end



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
