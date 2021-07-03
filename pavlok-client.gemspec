# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "pavlok-client"
  spec.version       = "0.1.0"
  spec.authors       = ["Azmat Rana"]
  spec.email         = ["azmat.rana01@gmail.com"]

  spec.summary       = "Ruby SDK for Pavlok"
  spec.description   = "Ruby SDK for Pavlok"
  spec.homepage      = "https://github.com/azmatrana/pavlok-client"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"
  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = `git ls-files`.split("\n")
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
