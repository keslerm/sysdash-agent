require 'server_console/agent/version'
require 'json'
require 'rest-client'
require 'ohai'
require 'pp'
require 'usagewatch'


# This is not gonna stay like this
module ServerConsole
  module Agent
    def self.run(server, name, token)

      system = Ohai::System.new
      system.all_plugins

      usw = Usagewatch

      # Load average
      cpu_usage = usw.uw_cpuused

      RestClient.post "http://#{server}/server/heartbeat", {
                        'name' => name,
                        'token' => token,

                        # Stats
                        'uptime' => system.data['uptime'],
                        'cpu_usage' => cpu_usage

                      }.to_json, :content_type => :json, :accept => :json


    end
  end
end
