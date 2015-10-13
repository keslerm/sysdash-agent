require "server_console/agent/version"
require "json"
require "rest-client"
require "sysinfo"

# This is not gonna stay like this
module ServerConsole
  module Agent
    def self.run(server, name, token)

      sysinfo = SysInfo.new

      RestClient.post "http://#{server}/server/checkin", {
                        'name' => name,
                        'token' => token,

                        # Stats
                        'uptime' => sysinfo.uptime

                      }.to_json, :content_type => :json, :accept => :json


    end
  end
end
