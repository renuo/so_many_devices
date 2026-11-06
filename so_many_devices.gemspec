require_relative "lib/so_many_devices/version"

Gem::Specification.new do |spec|
  spec.name = "so_many_devices"
  spec.version = SoManyDevices::VERSION
  spec.authors = ["Alessandro Rodi"]
  spec.email = ["coorasse@gmail.com"]

  spec.summary = "A list of configurations for so many devices!"
  spec.description = "This incomplete but very satisfying list of devices, will help you run your app on so many devices!"
  spec.homepage = "https://github.com/renuo/so_many_devices"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.3.0"

  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ spec/ logo/ .git .github .semaphore .rspec .ruby-version Gemfile])
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara", ">= 3.0"
end
