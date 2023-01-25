RSpec.describe SoManyDevices do
  it "has a version number" do
    expect(SoManyDevices::VERSION).not_to be nil
  end

  it "defines a list of devices" do
    devices = YAML.load_file(File.join(__dir__, "../lib/so_many_devices.yml"))
    already_available_devices = 5
    chrome_with_download_devices = 2
    expect(Capybara.drivers.length).to eq((devices.keys.length * 2) +
                                              already_available_devices +
                                              chrome_with_download_devices)
  end
end
