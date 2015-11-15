require 'images_url_maker'

RSpec.describe ImagesUrlMaker do
  let(:url) { 'http://guides.rubyonrails.org/v4.1/getting_started.html' }
  let(:base_url) { 'http://guides.rubyonrails.org/' }
  let!(:images_url_maker) { described_class.new(url) }
  
  describe '#initialize' do
    it 'should initialize instance variables' do
      obj_base_url = images_url_maker.instance_variable_get('@base_url')
      expect(obj_base_url).to eq base_url
    end
  end

  describe '#make' do
    context 'when image url is full url' do
      let(:image_url) { 'http://guides.rubyonrails.org/v4.1/images/getting_started/rails_welcome.png' }

      it 'should return image url as is' do
        expect(images_url_maker.make(image_url)).to eq image_url
      end
    end

    context 'when image url is relative url' do
      let(:image_url) { '/v4.1/images/getting_started/rails_welcome.png' }
      
      it 'should return image url with base url' do
        expect(images_url_maker.make(image_url)).to eq "#{base_url}#{image_url}"
      end
    end
  end

end