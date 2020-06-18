# So Many Devices! 🕺

[![status](https://renuo.semaphoreci.com/badges/so_many_devices.svg)](https://renuo.semaphoreci.com/projects/so_many_devices)

This gem provides a list of Capybara Selenium configurations that you can use.
Probably useful to run your system tests on different devices.

## Installation

Here is how you can use it in RSpec but you can, of course, use it wherever you want:

Add this line to your application's Gemfile, in group tests:

```ruby
group :test do
  gem 'so_many_devices'
end
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install so_many_devices

## Usage

In your `rails_helper.rb` you can configure your preferred device for tests:

```ruby
config.before(:each, type: :system, js: true) do
  driven_by :iphone_6_7_8
end
```

You can always use the headless version of each device by appending `_headless` to the device name.

```ruby
config.before(:each, type: :system, js: true) do
  driven_by :iphone_6_7_8_headless
end
```

We use it to run our system tests on so many devices! Here is our standard configuration:

```ruby
config.before(:each, type: :system, js: true) do
  driven_by ENV['SELENIUM_DRIVER'].to_sym
end
```

and then we can run

```sh
SELENIUM_DRIVER=iphone_6_7_8_headless bundle exec rspec --pattern "**/system/**/*_spec.rb"
SELENIUM_DRIVER=selenium_chrome_headless bundle exec rspec --pattern "**/system/**/*_spec.rb"
```

of course, your tests need to run on so many devices!
 
## Available devices

Check [the YML file containing all the devices](./lib/so_many_devices.yml). So many!

## Chrome with downloads capabilities

We provide also an instance of Chrome already configured with 
Downloads capabilities and a `SoManyDevices::DownloadsHelper` that you can use in your project.

Use the following:

```ruby
config.before(:each, type: :system, js: true) do
  driven_by :selenium_chrome_with_download_headless # or non-headless version
end

config.include SoManyDevices::DownloadsHelper, type: :system
```

and in your test (just an example...):

```ruby
it 'can download a file', :js do
  visit funny_page_path
  click_link 'Download PDF'
  wait_for_download
  expect(downloads.length).to eq(1)
  expect(download).to match(/.*\.pdf/)
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. 
Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. 
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, 
which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/renuo/so_many_devices>. 
This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/renuo/so_many_devices/blob/master/CODE_OF_CONDUCT.md).

Do you think our devices are not that many? 😡

Please contribute by adding more devices to the list, so that they can be even more...many...😕...and the next person coming cannot say "they are not that many..."

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SoManyDevices project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/renuo/so_many_devices/blob/master/CODE_OF_CONDUCT.md).


## Special Thanks

[![Renuo AG](./logo/renuo.png)](https://www.renuo.ch)
