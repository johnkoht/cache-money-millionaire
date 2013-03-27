# CacheMoneyMillionaire

Rails ActiveRecord Query Caching like a Millionaire

CacheMoneyMillionaire is a simple Ruby gem that extends Rail's basic find, save and touch methods to create, set and update cache keys for ActiveRecord models. 

## Installation

Add this line to your application's Gemfile:

    gem 'cache_money_millionaire'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cache_money_millionaire

## Usage

In order to get started, make sure you add the initializer:
  
    # config/initializers/cache_money_millionaire.rb
    CacheMoneyMillionaire.configure do |config|
      config.cacheable = true
      config.expires_in = 30.days
    end
    
Caching will only occur if the config.cacheable AND your Rails application is set to perform_caching. Please note that development environments have caching turned off, so if you want to test locally, make sure you update your development.rb.

That's it! Everything else is automatic!

### Skip Caching

If you want, you can ignore the cached version when fetching a model, to do so, simple do:
  
    # Get a fresh copy of the record by bypassing the cached version
    Post.find(3, cache: false)

### ActiveRecord Collection and Array Helper

There are two active record patches for the ActiveRecord Collections and Array. These allow you to call .cache_key on a collection or an array and receive an MD5 hash for caching:

    # Cache key for all posts
    Post.published.all.cache_key
    # => "ba6a3c1d35e7c7d1b4acdcd5330f8891"
    
    # Cache key for paginated post collection
    Post.published.page(params[:page]).per(20)
    # => "b7ff80c902b673c03b5f195dcf3e492e"
    
    # Cache key for Arrays
    tags = Post.find(3).tags
    tags.cache_key
    # => "9d72ecf5ab79e30cfe67fe5ee0b03aa9"

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
