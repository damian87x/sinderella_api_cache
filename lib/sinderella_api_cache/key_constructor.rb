module SinderellaApiCache


  class KeyConstructor

    def initialize(endpoint, class_name)
      @params_grape = endpoint.params
      @route_info = @params_grape.route_info
      @target = class_name
      prepare
    end

    def prepare
      String.class_eval do
        def is_special_key?
          !match(/^:.*/).blank?
        end

        def param_correction
          gsub('-', '/')
        end

        def is_wrong_param?
          !match(/-/).blank?
        end

        def to_parts
          split('/')
        end
      end
      @params_grape.delete('route_info')
    end

    def correct_params
      new_params = @params_grape
      new_params.each do |key,value|
        @params_grape[key] = value.param_correction
      end
      ActiveSupport::HashWithIndifferentAccess.new(@params_grape)
    end

    def doit
      give_access unless has_access?
      case decide
        when :child_strategy
          target = @target.where(correct_params).first
          if child_target(target)
            default_key + [@child_target.count]
          end
        when :single
          default_key
        when :many
          default_key
      end
    end

    def child_target(target)
      @child_target ||=  target.send(child_key)
    end

    def default_key
      [@target, path, @params_grape]
    end

    def child_key
      path.to_parts.last.gsub('(.:format)','')
    end

    private

    def has_access?
      true if @route_info.respond_to? :options
    end

    def give_access
      @route_info.class_eval do
        attr_reader :options
      end
      true
    end

    def path
      @path ||= @route_info.options[:path]
    end

    def decide
      return :many if path.to_parts.size == 3
      return :child_strategy if path.to_parts[-2].include?(':')
      :single if keys.size >= 2 && path.to_parts.last.is_special_key?
    end


    def keys
      @path.to_parts.map { |e| e.is_special_key? }.uniq.compact.reject { |e| e == ':version' }
    end

  end



end


