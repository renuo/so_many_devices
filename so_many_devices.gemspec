require_relative 'lib/so_many_devices/version'

Gem::Specification.new do |spec|
  spec.name          = "so_many_devices"
  spec.version       = SoManyDevices::VERSION
  spec.authors       = ["Alessandro Rodi"]
  spec.email         = ["coorasse@gmail.com"]

  spec.summary       = %q{A list of configurations for so many devices!}
  spec.description   = %q{This incomplete but very satisfying list of devices, will help you run your app on so many devices!}
  spec.homepage      = "https://github.com/renuo/so_many_devices"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/renuo/so_many_devices"
  spec.metadata["changelog_uri"] = "https://github.com/renuo/so_many_devices/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'capybara', '>= 3.0'
end
