require 'garner/mixins/rack'
require 'sinderella_api_cache/extended/grape_add'
require 'sinderella_api_cache/key_constructor'

module SinderellaApiCache

  module CacheApi


    include ActionController::HttpAuthentication::Token::ControllerMethods
    include Garner::Mixins::Rack

    def const_key(class_name)
      c = SinderellaApiCache::KeyConstructor.new(self, class_name)
      c.doit
    end

    def authentication(&block)
      # return true if Rails.env == 'development'
      return false if request.headers["Authorization"].blank?
      authenticate_or_request_with_http_token do |token, options|
        (block.call == token)
      end
    end


    def cache_api(op, &block)
      op[:expires_in] ||= 2.hours
      op[:bind] ||= const_key(op[:class_name])
      [:class_name, :is_count].each { |e| op.delete(e) }
      garner.options(op) do
        block.call
      end
    end

  end


end