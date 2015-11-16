require_relative '../html_doc'
require_relative 'url_maker'

module Images
  class Urls
    def initialize(url)
      @html_doc = HtmlDoc.new(url).doc
      @url_maker = UrlMaker.new(url)
    end

    def urls
      tags.map { |img| @url_maker.make(img['src']) }.uniq
    end

  private

    def tags
      @html_doc.css('img')
    end
  end
end