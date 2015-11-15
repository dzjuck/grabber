require 'open-uri'
require 'nokogiri'
require_relative 'images_urls'
require_relative 'images_loader'
require_relative 'images_saver'

# 1. получение параметров снаружи
# +2. загрузка html
# +3. получение урлов картинок
# +4. подготовка урл картинок
# +5. подготовка пути сохранения картинок
# +6. загрузка и сохранение картинок

class Grabber
  def initialize(url:, save_dir:)
    @url = prepare_url(url)
    @save_dir = save_dir
  end

  def grab
    # puts images_urls
    images_urls.each do |image_url|
      save_image(image_url)
    end
  end

private

  def save_image(image_url)
    ImagesSaver.new(@save_dir, image_url, load_image(image_url)).save
  end

  def prepare_url(url)
    url = "http://#{url}" if URI.parse(url).scheme.nil?
    url
  end

  def load_image(url)
    ImagesLoader.new(url).load
  end

  def images_urls
    ImagesUrls.new(@url).urls
  end
end