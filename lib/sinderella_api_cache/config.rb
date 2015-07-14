# module SinderellaApiCache
#   class << self
#
#     def configure
#       block_given? ? yield(Garner::Config) : Garner::Config
#     end
#     alias_method :config, :configure
#   end
#
#   module Config
#     extend self
#
#
#
#   end
#
#
#
# end