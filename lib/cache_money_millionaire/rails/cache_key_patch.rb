# CacheKey Patch
# Add cache_key methods to Arrays and ActiveRecord collections which allows us to
# easily cache sets of data without any problems.

# example: Posts.all.cache_key
# example: Posts.published.page(params[:page]).per(20).cache_key

# This is great for HTTP caching in the controller, here's a quick example:
# @posts = Post.scoped.published.page(params[:page]).per(10)	  
# if stale?(etag: @posts.cache_key, last_modified: @posts.maximum(:updated_at), public: true)
#   ...
# end


# Extend Array to include a cache_key method
class Array
  def cache_key
    Digest::MD5.hexdigest "#{self.count}-#{self.inspect}"
  end
end


# Extend ActiveRecord::Base Collections to include a cache_key method
module ActiveRecord
  class Base
    def self.cache_key
      Digest::MD5.hexdigest "#{scoped.maximum(:updated_at).try(:to_i)}-#{scoped.count}"
    end
  end
end