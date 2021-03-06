# Undertaker
[![Build
Status](https://travis-ci.org/blamattina/undertaker.png?branch=master)](https://travis-ci.org/blamattina/undertaker)
[![Gem
Version](https://badge.fury.io/rb/undertaker-rails.png)](http://badge.fury.io/rb/undertaker-rails)

Easy exponential back off.

Undertaker will run a block of code and if it raises an exception it will
retry.

## Installation

Add this line to your application's Gemfile:

    gem 'undertaker-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install undertaker-rails

## Usage

### Retry any StandardError

```ruby
undertaker = Undertaker.new(limit: 5, logger: Rails.logger)

undertaker.execute do
  something...
end
```

### With a custom retry condition

```ruby
undertaker = Undertaker.new

undertaker.retry_when { |exception| exception == SomeError }

undertaker.execute do
  something...
end
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/undertaker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
