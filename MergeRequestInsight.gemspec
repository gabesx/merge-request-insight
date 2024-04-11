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

  # Explicitly specify files, excluding .gem files
  spec.files = Dir.glob("{bin,lib}/**/*", File::FNM_DOTMATCH) + Dir.glob("*.{md,gemspec,yml}")
  spec.files.reject! { |file| file.end_with?('.gem') || file.include?('.git') || file.include?('tmp') }

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
