require "cache_money_millionaire/version"
require "cache_money_millionaire/config"
require "cache_money_millionaire/rails/active_record_patch"
require "cache_money_millionaire/rails/cache_key_patch"

module CacheMoneyMillionaire
      
  extend Config
  
  class << self  
    def initialize attrs={}
      puts "initialize..."
      attrs = CacheMoneyMillionaire.options.merge(attrs)
      Config::VALID_OPTION_KEYS.each do |key|
        instance_variable_set("@#{key}".to_sym, attrs[key])
      end
    end
  end
    
end