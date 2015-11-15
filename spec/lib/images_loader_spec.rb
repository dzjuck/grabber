require 'images_loader'

RSpec.describe ImagesLoader do
  let(:url) { 'http://guides.rubyonrails.org/v4.1/images/getting_started/rails_welcome.png' }
  let!(:images_loader) { described_class.new(url) }
  
  describe '#initialize' do
    it 'should initialize instance variables' do
      obj_url = images_loader.instance_variable_get('@url')
      expect(obj_url).to eq url
    end
  end

  describe '#load' do
    def stub_nokogiri
      allow(Nokogiri).to receive(:HTML)
    end

    it 'should load image' do
      stub_nokogiri

      temp_file_obj = double('Tempfile')
      expect(images_loader).to receive(:open).with(url) { temp_file_obj }
      expect(temp_file_obj).to receive(:read)
    end

    after(:each) do
      images_loader.load
    end
  end

end