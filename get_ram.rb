require 'systeminformation'
require 'net/http'
require 'uri'
require 'json'

uri = URI.parse("http://ramstatus.herokuapp.com/memories")

header = {'Content-Type': 'text/json'}
#puts SystemInformation.memory
memory_free = SystemInformation.memory[:free]
memory_used = SystemInformation.memory[:used]

memories_obj = {memories: {
                   free: memory_free,
                   used: memory_used
                      }
            }

# Create the HTTP objects
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = memories_obj.to_json

# Send the request
response = http.request(request)

puts "response #{response}"

response.each do |key, value|
  puts "#{key}:#{value}"
end
