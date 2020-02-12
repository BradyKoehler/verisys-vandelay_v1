require_relative 'lib/contacts_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "contacts_parser"
  spec.version       = ContactsParser::VERSION
  spec.authors       = ["Brady Koehler"]
  spec.email         = ["me@bradykoehler.com"]

  spec.summary       = "This gem parses a CSV file of Vandelay Industries contacts and exports them as JSON."
  spec.homepage      = "https://github.com/BradyKoehler/verisys-vandelay_v1"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/BradyKoehler/verisys-vandelay_v1/tree/step1/contacts_parser"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = ["contacts_parser"]
  spec.require_paths = ["lib"]
end
