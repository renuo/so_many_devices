RSpec.describe SoManyDevices::DownloadsHelper do
  include SoManyDevices::DownloadsHelper

  it 'points to a tmp path' do
    FileUtils.mkdir_p(described_class::PATH)
    expect(described_class::PATH).to end_with('tmp/downloads')
    expect(downloads).to eq([])
    FileUtils.touch("#{described_class::PATH}/example.txt")
    expect(downloads).to eq(['example.txt'])
  end
end
