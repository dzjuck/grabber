require 'fileutils'

RSpec.describe 'Save dir is not writable' do
  url = 'http://guides.rubyonrails.org/v4.1/getting_started.html'
  save_dir = 'spec/tmp'

  before(:each) do
    FileUtils.rm_rf(save_dir) if File.exist?(save_dir)
    Dir.mkdir(save_dir)
    FileUtils.chmod('a-w', save_dir)
  end

  it_behaves_like 'failed script', url, save_dir

  after(:each) do
    FileUtils.rm_rf(save_dir) if File.exist?(save_dir)
  end
end