require 'grabber'

RSpec.describe Grabber do
  let(:url) { 'http://guides.rubyonrails.org/v4.1/getting_started.html' }
  let(:save_dir) { 'spec/tmp' }
  let!(:grabber) { described_class.new(url: url, save_dir: save_dir) }

  describe '#initialize' do
    it 'should initialize instance variables' do
      expect(grabber.instance_variable_get('@url')).to eq url
      expect(grabber.instance_variable_get('@save_dir')).to eq save_dir
    end

    context 'when url without scheme' do
      let(:url) { 'guides.rubyonrails.org/v4.1/getting_started.html' }

      it 'should prepare url' do
        expect(grabber.instance_variable_get('@url')).to eq "http://#{url}"
      end
    end
  end

  describe '#grab' do
    let(:images_urls) { ['url1', 'url2'] }
    let(:image) { 'image_data' }

    def stub_save_image
      allow(grabber).to receive(:save_image)
    end

    def stub_images_urls
      allow(grabber).to receive(:images_urls) { images_urls }
    end

    def stub_load_image
      allow(grabber).to receive(:load_image) { image }
    end

    it 'should get images urls' do
      stub_save_image

      expect(Images::Urls).to(
        receive_message_chain(:new, :urls)
          .with(url)
          .with(no_args) { images_urls }
      )
    end

    it 'should load images' do
      stub_images_urls
      allow(Images::Saver).to receive_message_chain(:new, :save)

      images_urls.each do |url|
        images_loader_obj = double('ImagesLoader')
        expect(Images::Loader).to receive(:new).with(url) { images_loader_obj }
        expect(images_loader_obj).to receive(:load)
      end
    end

    it 'should save images' do
      stub_images_urls
      stub_load_image

      images_urls.each do |url|
        images_saver_obj = double('ImagesSaver')
        expect(Images::Saver).to(
          receive(:new).with(save_dir, url, image) { images_saver_obj }
        )
        expect(images_saver_obj).to receive(:save)
      end
    end

    after(:each) do
      grabber.grab
    end
  end
end