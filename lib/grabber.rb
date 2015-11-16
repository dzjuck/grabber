require 'open-uri'
require 'nokogiri'
require_relative 'images'

class Grabber
  def initialize(url:, save_dir:)
    @url = prepare_url(url)
    @save_dir = save_dir
  end

  def grab
    images_urls.each do |image_url|
      save_image(image_url)
    end
  end

private

  def save_image(image_url)
    Images::Saver.new(@save_dir, image_url, load_image(image_url)).save
  end

  def prepare_url(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    url
  end

  def load_image(url)
    Images::Loader.new(url).load
  end

  def images_urls
    Images::Urls.new(@url).urls
  end
end