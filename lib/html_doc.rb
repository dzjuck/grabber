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
    fail('Https does not support') if URI.parse(@url).scheme == 'https'
    puts "Скачиваю html по адресу - #{@url}"
    open(@url).read
  end
end