require 'sinatra/base'
module Sinatra
  module PublishStatic
    def self.registered(app)
    end
    def static_publish(dir_path,template_rule)
      'OK!'
    end
  end
  register PublishStatic
#  Delegator.delegate :config_file
end
