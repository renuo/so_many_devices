require "so_many_devices/version"
require "so_many_devices/downloads_helper"
require 'yaml'
require 'capybara'

module SoManyDevices
  class Error < StandardError; end

  devices = YAML::load_file(File.join(__dir__, 'so_many_devices.yml'))

  devices.each do |device_name, options|
    standard_args = ['--disable-site-isolation-trials']
    headless_args = ['--headless', '--disable-site-isolation-trials']
    headless_args << '--disable-gpu' if Gem.win_platform?

    [[device_name, standard_args], ["#{device_name}_headless", headless_args]].each do |device_name, args|
      Capybara.register_driver device_name.to_sym do |app|
        capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
            'goog:chromeOptions' => { args: args, mobileEmulation: options }
        )
        Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
      end
    end

    [[:selenium_chrome_with_download, standard_args], [:selenium_chrome_with_download_headless, headless_args]].each do |device_name, args|
      Capybara.register_driver device_name do | app |
        browser_options = ::Selenium::WebDriver::Chrome::Options.new(args: args)
        browser_options.add_preference(:download, prompt_for_download: false, default_directory: SoManyDevices::DownloadsHelper::PATH.to_s)
        browser_options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })
        Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
      end
    end
  end
end
