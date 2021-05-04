class HardWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'your_queue'
  # include UploadsHelper


  def perform(post_id)
    #@post=Post.find(params[:post_id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name", template: "posts/show.html.erb"
      end
    end
  end

end
