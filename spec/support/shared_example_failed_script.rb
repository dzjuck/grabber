RSpec.shared_examples 'failed script' do |url, save_dir|
  let(:command) { "./grab.rb #{url} #{save_dir}" }
  let(:result_files) { Dir.entries(save_dir) }
  let(:should_be_files) { ['.', '..'] }

  it 'should be failed' do
    output = `#{command}`

    expect(output).to include('Fail')
  end

  it 'should not download images' do
    `#{command}`

    expect(result_files).to match_array(should_be_files) if Dir.exist?(save_dir)
  end
end
