module ActiveRecord
  class Base
    
    # Include the CacheMoneyMillionaire module
    extend CacheMoneyMillionaire
    
    
    # Extend the find method for ActiveRecord
    # This method will create or fetch a record by a cache key. If the record exists in cache
    # then we fetch it, otherwise, we'll create a cache key for it and store it in memory
    # To ignore cache, pass cache: false as a parameter
    
    def self.find *args
      # extract the options and see if the :cache: option was passed, and set the skip_cache
      # variable based on it's validity. Then we'll remove from the arguments and pass
      # the original arguments back into our hash
      options = args.extract_options!
      cache = options.delete(:cache) || true
      args.push(options)
      
      # If it's cacheable and cache isn't set to false, then let's CacheMoneyMillionaire this bitch!
      # We set the cache key to the object class name and id, i.e. Post 3, User 109, etc.
      if CacheMoneyMillionaire.cacheable? and cache
        model = Rails.cache.fetch (Digest::MD5.hexdigest "#{self} #{args[0]}"), expires_in: CacheMoneyMillionaire.options[:expires_in] do
          super *args
        end
      else
        # if no caching, then let's just ignore and call typical .find method
        super *args
      end
    end
    
    
    # Extend the save method for ActiveRecord
    # When an object is saved, let's update the cache key (the one we created above) so we can
    # invalidate our stale cache
    def save *args
      self.rewrite_cache
      super
    end
    
    
    # Extend the touch method for ActiveRecord
    # Similar to the save method extention, we'll just hijack the touch method and update the
    # cache key value with our updated data
    def touch
      super
      self.rewrite_cache
    end
    
    # rewrite the cache for this model
    def rewrite_cache
      if CacheMoneyMillionaire.cacheable?
        cache_key = Digest::MD5.hexdigest "#{self.class.name} #{self.id}"
        Rails.cache.write cache_key, self
      else
        false
      end
    end
         
  end
end