class HardWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker

  sidekiq_options queue: 'your_queue'
  # include UploadsHelper


  def perform(post_id)

    puts("It is executing 1")
    url = "/admin/posts"+post_id.to_s()
    pdf = WickedPdf.new.pdf_from_url(url)
    filename = 'Post_'+ post_id.to_s() +'.pdf'
    save_path = Rails.root.join('pdfs',filename)
    File.open(save_path, 'wb') do |file|
      file << pdf
    end






  end


end
