require 'fileutils'

RSpec.describe 'Save dir does not exist' do
  url = 'http://guides.rubyonrails.org/v4.1/getting_started.html'
  save_dir = 'does_not_exist'

  it_behaves_like 'failed script', url, save_dir
end