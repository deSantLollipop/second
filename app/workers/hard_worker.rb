class HardWorker
  include Sidekiq::Worker
  include Sidekiq::Status::Worker
  sidekiq_options retry: false

  def perform(post_id)
    @post = Post.find(post_id)
    pdf_html = Admin::PostsController.new.render_to_string(template: 'admin/posts/show.pdf.erb',
                                                           locals: { post: @post } )
    pdf = WickedPdf.new.pdf_from_string(pdf_html)
    filename = 'post_'+ post_id.to_s + '.pdf'
    save_path = Rails.root.join('public/assets', filename)
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end



end


=begin

    rendered_string = Admin::PostsController.render :show
    pdf = rendered_string.render pdf: "Post ##{ @post.id }",
                    file: "#{ Rails.root }/app/admin/assets/post_pdf.html.erb",
                    layout: 'layouts/codes',
                    page_height: '3.5in',
                    page_width: '2in',
                    margin: {  top: 2,
                               bottom: 2,
                               left: 3,
                               right: 3 },
                    disposition: 'attachment',
                    disable_javascript: true,
                    enable_plugins: false,
                    locals: { post: :@post }
=end