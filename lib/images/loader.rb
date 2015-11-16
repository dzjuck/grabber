require 'open-uri'

module Images
  class Loader
    def initialize(url)
      @url = url
    end

    def load
      puts "Скачиваю изображение - #{@url}"
      open(@url).read
    end
  end
end
