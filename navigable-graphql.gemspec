require_relative 'lib/navigable/graphql/version'

Gem::Specification.new do |spec|
  spec.name          = "navigable-graphql"
  spec.version       = Navigable::GraphQL::VERSION
  spec.authors       = ["Alan Ridlehoover", "Fito von Zastrow"]
  spec.email         = ["navigable@firsttry.software"]

  spec.summary       = %q{Ahoy! Navigable will get you there!}
  spec.description   = %q{We hold these truths to be self-evident, that not all objects are created equal, that poorly structured code leads to poorly tested code, and that poorly tested code leads to rigid software and fearful engineers.\n\nWe believe a framework should break free of this tyranny. It should be simple, testable, and fast. It can be opinionated. But, it should leverage SOLID principles to guide us toward well structured, well tested, maleable code that is truly navigable.}
  spec.homepage      = "https://github.com/first-try-software/navigable-graphql"
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

  spec.add_dependency 'hanami-router', '= 2.0.0.alpha3'
  spec.add_dependency 'json', '~> 2.3'
  spec.add_dependency 'navigable', '~> 0.2'
  spec.add_dependency 'rack', '~> 2.2'
  spec.add_dependency 'rack-bodyparser', '~> 1.0'
  spec.add_dependency 'graphql', '~> 1.11'
end