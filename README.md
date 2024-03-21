# merge-request-insight
 merge-request-insight is a Ruby gem that provides detailed analytics on GitLab merge requests, including status, authorship, and code changes. It simplifies tracking project contributions and codebase evolution, ideal for developers and project managers aiming for enhanced workflow visibility.



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'merge_request_insight', git: 'https://github.com/gabesx/merge-request-insight.git'
```

And then execute:

````bundle install````

Or install it yourself as:

```gem install merge_request_insight```

## Configuration
Before using MergeRequestInsight, configure it with your GitLab access token and project ID. It's recommended to manage your access token securely, avoiding hard-coding it within your scripts. You can use environment variables or other secure methods to set your token and project ID.

```
# Environment variables for access token and project ID
ENV['GITLAB_ACCESS_TOKEN'] = 'your_access_token'
ENV['GITLAB_PROJECT_ID'] = 'your_project_id'
```

Usage
Here's how to use merge-request-insight to fetch and process merge requests for a specified project:

```
require 'merge_request_insight'
```

## Contributing
Contributions are warmly welcomed and greatly appreciated! Here's how you can contribute:

1. Fork the repo on GitHub.
2. Clone your forked repository to your local machine.
3. Create a new feature branch (git checkout -b my-new-feature).
4. Make your changes and commit them (git commit -am 'Add some feature').
5. Push to the branch (git push origin my-new-feature).
6. Create a new Pull Request on GitHub.
