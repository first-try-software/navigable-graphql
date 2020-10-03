require_relative 'lib/navigable/graphql/version'

Gem::Specification.new do |spec|
  spec.name          = "navigable-graphql"
  spec.version       = Navigable::GraphQL::VERSION
  spec.authors       = ["Alan Ridlehoover", "Fito von Zastrow"]
  spec.email         = ["navigable@firsttry.software"]

  spec.summary       = %q{Ahoy! Welcome aboard Navigable!}
  spec.description   = %q{An extension of Navigable Server for building GraphQL APIs.}
  spec.homepage      = "https://firsttry.software"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/first-try-software/navigable-graphql"
  spec.metadata["bug_tracker_uri"] = "https://github.com/first-try-software/navigable-graphql/issues"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'graphql', '~> 1.11'
  spec.add_dependency 'json', '~> 2.3'
  spec.add_dependency 'navigable', '~> 1.3'
  spec.add_dependency 'navigable-server', '~> 0.5'
  spec.add_dependency 'rack', '~> 2.2'
  spec.add_dependency 'rack-bodyparser', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "~>0.4"
  spec.add_development_dependency "simplecov", "~>0.17.0"
end
