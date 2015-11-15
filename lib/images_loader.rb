require 'open-uri'

class ImagesLoader
  def initialize(url)
    @url = url
  end

  def load
    open(@url).read
  end
end