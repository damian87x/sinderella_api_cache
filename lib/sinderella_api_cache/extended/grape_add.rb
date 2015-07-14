module SinderellaApiCache::Extended

  module GrapeAdd

    Grape::Request.class_eval do
      def authorization
        @env['HTTP_AUTHORIZATION'] ||
            @env['X-HTTP_AUTHORIZATION'] ||
            @env['X_HTTP_AUTHORIZATION'] ||
            @env['REDIRECT_X_HTTP_AUTHORIZATION']
      end
    end


    Grape::Endpoint.class_eval do
      def render(args)
        false
      end
    end


  end


end