RSpec.describe SoManyDevices do
  let(:devices) { YAML.load_file(File.join(__dir__, "../lib/so_many_devices.yml")) }

  it "has a version number" do
    expect(SoManyDevices::VERSION).not_to be nil
  end

  it "registers a standard and a headless driver for each device" do
    devices.each_key do |device_name|
      expect(Capybara.drivers[device_name.to_sym]).not_to be_nil
      expect(Capybara.drivers[:"#{device_name}_headless"]).not_to be_nil
    end
  end

  it "emulates the device in chrome" do
    driver = Capybara.drivers[:iphone_6_7_8_headless].call(nil)
    chrome_options = driver.options[:options].as_json["goog:chromeOptions"]

    expect(chrome_options["args"]).to include("--headless")
    expect(chrome_options["mobileEmulation"]).to eq(devices["iphone_6_7_8"])
  end

  it "prefers reduced motion on all drivers" do
    driver_names = devices.keys.flat_map { |name| [name, "#{name}_headless"] } +
      %w[selenium_chrome_with_download selenium_chrome_with_download_headless]

    driver_names.each do |driver_name|
      driver = Capybara.drivers[driver_name.to_sym].call(nil)
      expect(driver.options[:options].args).to include("--force-prefers-reduced-motion")
    end
  end

  it "registers the chrome drivers with downloads" do
    driver = Capybara.drivers[:selenium_chrome_with_download].call(nil)
    prefs = driver.options[:options].as_json["goog:chromeOptions"]["prefs"]

    expect(prefs["download"]["default_directory"]).to eq(SoManyDevices::DownloadsHelper::PATH)
    expect(Capybara.drivers[:selenium_chrome_with_download_headless]).not_to be_nil
  end
end
