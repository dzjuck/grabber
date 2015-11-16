require 'fileutils'

RSpec.describe 'Download images' do

  context 'User provide valid url' do
    let(:dir) { 'spec/tmp' }

    before(:each) do
      FileUtils.rm_rf(dir) if File.exist?(dir)
      Dir.mkdir(dir)
    end

    let(:result_files) { Dir.entries(dir) }
    let(:should_be_files) { Dir.entries('spec/fixtures/files/rubyonrails_org') }

    context 'when url with scheme' do
      it 'should download all images' do
        `./grab.rb http://guides.rubyonrails.org/v4.1/getting_started.html spec/tmp`

        expect(result_files).to match_array(should_be_files)
      end
    end

    context 'when url without scheme' do
      it 'should download all images' do
        `./grab.rb guides.rubyonrails.org/v4.1/getting_started.html spec/tmp`

        expect(result_files).to match_array(should_be_files)
      end
    end

    after(:each) do
      FileUtils.rm_rf(dir) if File.exist?(dir)
    end
  end

end