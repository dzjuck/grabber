require_relative 'html_doc'
require_relative 'images_url_maker'

class ImagesUrls
  def initialize(url)
    @html_doc = HtmlDoc.new(url).doc
    @url_maker = ImagesUrlMaker.new(url)
  end

  def urls
    tags.map { |img| @url_maker.make(img['src']) }
  end

private

  def tags
    @html_doc.css('img')
  end
end