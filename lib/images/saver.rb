module Images
  class Saver
    def initialize(save_dir, image_url, image)
      @save_dir = save_dir
      @image_url = image_url
      @image = image
    end

    def save
      File.write(path, @image)
    end

  private

    def path
      "#{@save_dir}/#{filename}"
    end

    def filename
      File.basename(uri.path)
    end

    def uri
      URI.parse(@image_url)
    end
  end
end