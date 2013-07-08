# Q

Q is a lightweight promise implementation in Ruby.

## Installation

Add this line to your application's Gemfile:

    gem 'q-defer', require: 'q'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install q-defer

## Usage

Defer a single block:

```ruby
require "open-uri"

Q.defer do |defer|
  Thread.new do
    response = open("http://www.example.com")

    if response.status[0] == "200"
      defer.resolve(response)
    else
      defer.reject([response.status, response])
    end
  end
end.then do |result|
  puts "ok"
end.fail do |err, result|
  puts "status code: #{err[0]}"
end.always do
  puts "All finished!"
end
```

Defer multiple blocks:

```ruby
def defer_open(url)
  Q.defer do |defer|
    Thread.new do
      response = open("http://www.example.com")

      if response.status[0] == "200"
        defer.resolve(response)
      else
        defer.reject([response.status, response])
      end
    end
  end
end

Q.when([
  defer_open("http://www.example.com"),
  defer_open("http://www.google.com")
]).then do |results|
  puts "All successful!"
end.fail do |err, results|
  puts "Error: #{err}"
end.always do |results|
  puts "All successful or one failure."
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
