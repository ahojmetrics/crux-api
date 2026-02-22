# CruxApi

A simple Ruby gem for querying Google's [Chrome UX Report (CrUX) API](https://developer.chrome.com/docs/crux/api). Retrieve real-time and historical field performance data for any URL on the web.

## Installation

Add the gem to your Gemfile:

```ruby
gem 'crux_api'
```

Then run:

```sh
bundle install
```

Or install it directly:

```sh
gem install crux_api
```

You can also install directly from GitHub:

```ruby
gem 'crux_api', github: 'ahojmetrics/crux-api'
```

## Requirements

- Ruby 3.0+
- Rails (the gem uses `Rails.cache` for caching API responses)
- A [Google API key](https://developer.chrome.com/docs/crux/api#APIKey) with the CrUX API enabled

Set your API key as an environment variable:

```sh
export GOOGLE_API_KEY=your_api_key_here
```

## Usage

### Initialize the client

```ruby
client = CruxApi::Client.new
```

The client reads your API key from the `GOOGLE_API_KEY` environment variable automatically.

### Get real-time performance data

Fetch the latest 28-day rolling performance metrics for a URL:

```ruby
result = client.get("https://example.com")
```

### Get historical performance data

Fetch month-by-month historical metrics (mobile) for a URL:

```ruby
history = client.history("https://example.com")
```

Both methods cache results for 12 hours via `Rails.cache` to reduce unnecessary API calls.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then run `rake spec` to run the tests. You can also use `bin/console` for an interactive prompt.

To install this gem locally:

```sh
bundle exec rake install
```

To release a new version, update the version number in `version.rb`, then run:

```sh
bundle exec rake release
```

This creates a git tag, pushes commits and the tag, and publishes the gem to [RubyGems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/ahojmetrics/crux-api). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ahojmetrics/crux-api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CruxApi project's codebase and issue trackers is expected to follow the [code of conduct](https://github.com/ahojmetrics/crux-api/blob/main/CODE_OF_CONDUCT.md).
