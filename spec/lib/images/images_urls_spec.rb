require 'images/urls'

RSpec.describe Images::Urls do
  let(:url) { 'http://guides.rubyonrails.org/v4.1/getting_started.html' }

  describe '#initialize' do
    def stub_html_doc
      allow(HtmlDoc).to receive_message_chain(:new, :doc)
    end

    def stub_images_url_maker
      allow(Images::UrlMaker).to receive(:new)
    end

    it 'should load html doc' do
      stub_images_url_maker

      expect(HtmlDoc).to(
        receive_message_chain(:new, :doc).with(url).with(no_args)
      )
    end

    it 'should init url maker' do
      stub_html_doc

      expect(Images::UrlMaker).to receive(:new).with(url)
    end

    after(:each) do
      described_class.new(url)
    end
  end

  describe '#urls' do
    let(:html_doc) { double('html_doc') }
    let(:url_maker) { double('url_maker') }
    let(:tags) { 
      [double('img tag 1', :[] => 'src 1'), 
       double('img tag 2', :[] => 'src 2')] 
    }
    let!(:images_urls) do 
      allow(HtmlDoc).to receive_message_chain(:new, :doc) { html_doc }
      allow(Images::UrlMaker).to receive(:new) { url_maker }
      described_class.new(url) 
    end

    def stub_url_maker
      allow(url_maker).to receive(:make)
    end

    def stub_tags
      allow(images_urls).to receive(:tags) { tags }
    end

    def stub_tags_map
      allow(images_urls).to(
        receive_message_chain(:tags, :map) { tags }
      )
    end

    it 'should load images tags' do
      stub_url_maker

      expect(html_doc).to receive(:css).with('img') { tags }
      
      images_urls.urls
    end

    it 'should make url for each image tag' do
      stub_tags

      tags.each do |tag|
        expect(url_maker).to receive(:make).with(tag['src'])
      end

      images_urls.urls
    end

    context 'when urls repeating' do
      let(:tag_1) { double('img tag 1', :[] => 'src 1') }
      let(:tag_2) { double('img tag 2', :[] => 'src 2') }
      let(:tags) { [tag_1, tag_2, tag_1] }

      it 'should return only unique urls' do
        stub_tags_map

        res = images_urls.urls
        expect(res).to match_array([tag_1, tag_2])
      end
    end

  end
end