require 'garner/mixins/rack'
require 'sinderella_api_cache/extended/grape_add'
require  'sinderella_api_cache/key_constructor'

module SinderellaApiCache

  module CacheApi


    include ActionController::HttpAuthentication::Token::ControllerMethods
    include Garner::Mixins::Rack

    def const_key(class_name)
      c = SinderellaApiCache::KeyConstructor.new(self, class_name)
      c.doit
    end


    def cache_api(op, &block)
      op[:expires_in] ||= 2.hours
      op[:bind] ||= const_key(op[:class_name])
      op.delete(:class_name)
      garner.options(op) do
        block.call
      end
    end

  end




end