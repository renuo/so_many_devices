require "so_many_devices/version"
require "so_many_devices/downloads_helper"
require "yaml"
require "capybara"

module SoManyDevices
  class Error < StandardError; end

  standard_args = ["--disable-site-isolation-trials", "--force-prefers-reduced-motion"]
  headless_args = ["--headless", *standard_args]
  headless_args << "--disable-gpu" if Gem.win_platform?

  devices = YAML.load_file(File.join(__dir__, "so_many_devices.yml"))

  devices.each do |device_name, emulation|
    [[device_name, standard_args], ["#{device_name}_headless", headless_args]].each do |driver_name, args|
      Capybara.register_driver driver_name.to_sym do |app|
        browser_options = ::Selenium::WebDriver::Chrome::Options.new(args: args, emulation: emulation)
        Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
      end
    end
  end

  [[:selenium_chrome_with_download, standard_args], [:selenium_chrome_with_download_headless, headless_args]].each do |driver_name, args|
    Capybara.register_driver driver_name do |app|
      browser_options = ::Selenium::WebDriver::Chrome::Options.new(args: args)
      browser_options.add_preference(:download, prompt_for_download: false, default_directory: SoManyDevices::DownloadsHelper::PATH.to_s)
      browser_options.add_preference(:browser, set_download_behavior: {behavior: "allow"})
      Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
    end
  end
end
