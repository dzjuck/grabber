require 'fileutils'

RSpec.describe 'Url does not exist' do
  url = 'http://guides.rubyonrails.org/v4.1/getting_started.htmlasdf'
  save_dir = 'spec/tmp'

  before(:each) do
    FileUtils.rm_rf(save_dir) if File.exist?(save_dir)
    Dir.mkdir(save_dir)
  end

  it_behaves_like 'failed script', url, save_dir

  after(:each) do
    FileUtils.rm_rf(save_dir) if File.exist?(save_dir)
  end
end