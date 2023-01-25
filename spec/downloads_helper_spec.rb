RSpec.describe SoManyDevices::DownloadsHelper do
  let(:test_file) { "#{described_class::PATH}/example.txt" }

  include SoManyDevices::DownloadsHelper

  before do
    FileUtils.rm(test_file, force: true)
  end

  after do
    FileUtils.rm(test_file, force: true)
  end

  it 'points to a tmp path' do
    FileUtils.mkdir_p(described_class::PATH)
    expect(described_class::PATH).to end_with('tmp/downloads')
    expect(downloads).to eq([])
    FileUtils.touch(test_file)
    expect(downloads.first).to end_with('example.txt')
    expect(first_download).to eq(downloads.first)
    expect(last_download).to eq(downloads.last)
  end
end
