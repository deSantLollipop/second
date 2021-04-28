class HardWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'your_queue'
  # include UploadsHelper


  def perform(post_id)
    #@post=Post.find(params[:post_id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Invoice No. #{post_id}",
               page_size: 'A4',
               template: "posts/show.html.erb",
               layout: "pdf.html",
               orientation: "Landscape",
               lowquality: true,
               zoom: 1,
               dpi: 75
      end
    end

  end
end
