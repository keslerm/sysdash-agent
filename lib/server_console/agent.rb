require 'server_console/agent/version'
require 'json'
require 'rest-client'
require 'ohai'
require 'pp'
require 'usagewatch'
require 'yaml'

# This is not gonna stay like this
module ServerConsole
  module Agent
    def self.run

      config = YAML.load(File.open('.config.yml'))

      system = Ohai::System.new
      system.all_plugins

      usw = Usagewatch

      # Load average
      cpu_usage = usw.uw_cpuused

      # Memory usage
      mem_total = system.data['memory']['total'].gsub('kB', '').to_i
      mem_free = system.data['memory']['free'].gsub('kB', '').to_i + system.data['memory']['cached'].gsub('kB', '').to_i + system.data['memory']['buffers'].gsub('kB', '').to_i
      mem_used = mem_total - mem_free


      RestClient.post "#{config['host']}/events/heartbeat", {
                        'name' => config['name'],
                        'token' => config['token'],

                        # Stats
                        'uptime' => system.data['uptime'],
                        'cpu_usage' => cpu_usage,
                        'mem_total' => mem_total,
                        'mem_used' => mem_used


                      }.to_json, :content_type => :json, :accept => :json


    end

    def self.message(subject, body)
      config = YAML.load(File.open('.config.yml'))

      RestClient.post "#{config['host']}/events/message", {
          'name': config['name'],
          'token': config['token'],
          'body': body,
          'subject': subject
      }.to_json, :content_type => :json, :accept => :json
    end
  end

end
