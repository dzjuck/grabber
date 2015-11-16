require 'images/saver'

RSpec.describe Images::Saver do
  let(:save_dir) { '/tmp' }
  let(:image_url) { 'http://guides.rubyonrails.org/v4.1/images/getting_started/rails_welcome.png' }
  let(:image) { 'image data' }
  let!(:images_saver) { described_class.new(save_dir, image_url, image) }
  
  describe '#initialize' do
    it 'should initialize instance variables' do
      expect(images_saver.instance_variable_get('@save_dir')).to eq save_dir
      expect(images_saver.instance_variable_get('@image_url')).to eq image_url
      expect(images_saver.instance_variable_get('@image')).to eq image
    end
  end

  describe '#save' do
    let(:path) { '/tmp/rails_welcome.png' }
    let(:filename) { 'rails_welcome.png' }

    def stub_path
      allow(images_saver).to receive(:path) { path }
    end

    def stub_filename
      allow(images_saver).to receive(:filename) { filename }
    end

    it 'should write to file' do
      stub_path

      expect(File).to receive(:write).with(path, image)
    end

    it 'should make correct path' do
      stub_filename

      expect(File).to receive(:write).with(path, image)
    end

    it 'should make correct filename' do
      path_uri_dbl = double('path')
      expect(URI).to receive_message_chain(:parse, :path) { path_uri_dbl }
      expect(File).to receive(:basename).with(path_uri_dbl) { filename }

      expect(File).to receive(:write).with(path, image)
    end

    after(:each) do
      images_saver.save
    end
  end

end