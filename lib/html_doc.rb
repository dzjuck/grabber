require 'open-uri'
require 'nokogiri'

class HtmlDoc
  def initialize(url)
    @url = url
  end

  def doc
    Nokogiri::HTML(html)
  end

private

  def html
    open(@url).read
  end
end