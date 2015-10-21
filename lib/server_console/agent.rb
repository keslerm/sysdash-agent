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

      # Memory usage
      mem_total = system.data['memory']['total'].gsub('kB', '').to_i
      mem_free = system.data['memory']['free'].gsub('kB', '').to_i + system.data['memory']['cached'].gsub('kB', '').to_i + system.data['memory']['buffers'].gsub('kB', '').to_i
      mem_used = mem_total - mem_free


      RestClient.post "#{server}/heartbeat", {
                        'name' => name,
                        'token' => token,

                        # Stats
                        'uptime' => system.data['uptime'],
                        'cpu_usage' => cpu_usage,
                        'mem_total' => mem_total,
                        'mem_used' => mem_used


                      }.to_json, :content_type => :json, :accept => :json


    end
  end
end
