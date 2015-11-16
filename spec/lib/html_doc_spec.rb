require 'html_doc'
require 'nokogiri'

RSpec.describe HtmlDoc do
  let(:url) { 'http://guides.rubyonrails.org/v4.1/getting_started.html' }
  let!(:html_doc) { described_class.new(url) }

  describe '#initialize' do
    it 'should initialize instance variables' do
      expect(html_doc.instance_variable_get('@url')).to eq url
    end
  end

  describe '#doc' do
    let(:html) { 'some html' }

    def stub_nokogiri
      allow(Nokogiri).to receive(:HTML)
    end

    def stub_load_html
      allow(html_doc).to receive(:html) { html }
    end

    context 'when url with http scheme' do
      it 'should load html' do
        stub_nokogiri

        expect(html_doc).to(
          receive_message_chain(:open, :read).with(url).with(no_args)
        )
      end

      it 'should parse html' do
        stub_load_html

        expect(Nokogiri).to receive(:HTML).with(html)
      end

      after(:each) do
        html_doc.doc
      end
    end

    context 'when url with https scheme' do
      let(:url) { 'https://guides.rubyonrails.org/v4.1/getting_started.html' }
      it 'should raise error' do 
        expect { html_doc.doc }.to raise_error
      end
    end
  end
end