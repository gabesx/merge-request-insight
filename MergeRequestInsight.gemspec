# frozen_string_literal: true

require_relative "lib/MergeRequestInsight/version"

Gem::Specification.new do |spec|
  spec.name = "MergeRequestInsight"
  spec.version = MergeRequestInsight::VERSION
  spec.authors = ["gabesx"]
  spec.email = ["judgement_sanctuary@yahoo.com"]

  spec.summary = "A tool to provide insights into merge requests for better code review management."
  spec.description = "MergeRequestInsight helps developers and team leads manage code reviews more effectively by providing detailed insights into merge requests, such as code complexity and potential bottlenecks. It integrates seamlessly into existing workflows, making the code review process more efficient and productive."
  spec.homepage = "https://github.com/gabesx/Merge-Request-Insight"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/gabesx/Merge-Request-Insight"
  spec.metadata["changelog_uri"] = "https://github.com/gabesx/Merge-Request-Insight/blob/master/CHANGELOG.md"
  
  
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
