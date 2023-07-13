# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

require "nordigen_ruby/version"

Gem::Specification.new do |spec|
  spec.name = "nordigen-ruby"
  spec.version = Nordigen::VERSION
  spec.authors = ["Nordigen Solutions"]
  spec.email = ["bank-account-data-support@gocardless.com"]
  spec.summary = "Nordigen client for Ruby"
  spec.homepage = "https://github.com/nordigen/nordigen-ruby"
  spec.description = "Nordigen official API client for Ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = "https://github.com/nordigen/nordigen-ruby"
  spec.metadata["bug_tracker_uri"] = "https://github.com/nordigen/nordigen-ruby/issues"
  spec.metadata["changelog_uri"] = "https://github.com/nordigen/nordigen-ruby/blob/master/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://github.com/nordigen/nordigen-ruby"
  spec.metadata["github_repo"] = "https://github.com/nordigen/nordigen-ruby"
  spec.metadata["source_code_uri"] = "https://github.com/nordigen/nordigen-ruby"

  ignored = Regexp.union(
    /\A\.env.template/,
    /\A\.git/,
    /\Atest/,
    /\Aexample/,
    /\Amain.rb/
  )
  spec.files = `git ls-files`.split("\n").reject { |f| ignored.match(f) }
  spec.executables   = `git ls-files -- bin/*`.split("\n")
                      .map { |f| ::File.basename(f) }

  spec.add_dependency "faraday", "~> 2.5"

  spec.require_paths = ["lib"]

end
