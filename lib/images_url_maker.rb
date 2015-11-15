class ImagesUrlMaker
  def initialize(url)
    @base_url = base_url(url)
  end

  def make(str)
    if URI.parse(str).host.nil?
      "#{@base_url}#{str}" 
    else
      str
    end
  end

private

  def base_url(url)
    uri = URI.parse(url)
    "#{uri.scheme}://#{uri.host}/"
  end
end