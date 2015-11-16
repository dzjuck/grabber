require 'open-uri'
require 'nokogiri'
require_relative 'images'

class Grabber
  def initialize(url:, save_dir:)
    @url = prepare_url(url)
    @save_dir = save_dir
  end

  def grab
    check_save_dir
    process_images
    puts 'Done'
  rescue => e
    puts "Fail: #{e.message}"
  end

private

  def process_images
    puts "Найдено картинок - #{images_urls.length}"
    images_urls.each do |image_url|
      save_image(image_url)
    end
  end

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
    @images_urls ||= Images::Urls.new(@url).urls
  end

  def check_save_dir
    unless Dir.exist?(@save_dir)
      fail("Directory '#{save_dir}' does not exist")
    end
    unless File.writable?(@save_dir)
      fail("Don't have write permission for directory '#{@save_dir}'")
    end
  end
end