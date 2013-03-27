module CacheMoneyMillionaire
  module Config
        
    VALID_OPTION_KEYS = [
      :cacheable,
      :expires_in
    ]
    
    attr_accessor *VALID_OPTION_KEYS
    
    def configure
      yield self
      self
    end
    
    def options
      options = {}
      VALID_OPTION_KEYS.each{ |pname| options[pname] = send(pname) }
      options
    end
    
    # Is the application cacheable? We'll only perform caching if the perform_caching
    # setting is true
    def cacheable?
      Rails.application.config.action_controller.perform_caching and options[:cacheable]
      #true
    end
        
  end
end