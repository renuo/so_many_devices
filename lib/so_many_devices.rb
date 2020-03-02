require "so_many_devices/version"

module SoManyDevices
  class Error < StandardError;
  end

  devices = YAML::load_file(File.join(__dir__, 'so_many_devices.yml'))

  devices.each do |device_name, options|
    standard_args = ['--disable-site-isolation-trials']
    headless_args = ['--headless', '--disable-site-isolation-trials']
    headless_args << '--disable-gpu' if Gem.win_platform?

    [[device_name.to_sym, standard_args], ["#{device_name}_headless".to_sym, headless_args]].each do |device_name, args|
      Capybara.register_driver device_name.to_sym do |app|
        capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
            'goog:chromeOptions' => { args: args, mobileEmulation: options }
        )
        Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: capabilities)
      end
    end
  end
end
