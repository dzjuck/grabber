require 'images/loader'

RSpec.describe Images::Loader do
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

      expect(images_loader).to(
        receive_message_chain(:open, :read).with(url).with(no_args)
      )
    end

    after(:each) do
      images_loader.load
    end
  end

end