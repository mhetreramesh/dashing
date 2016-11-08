require 'net/http'
require 'uri'
require 'json'

server = "http://dev.vegfru.com"

SCHEDULER.every '10s', :first_in => 0 do |job|

	url = URI.parse("#{server}/api/v1/users-monthly-stats")
	req = Net::HTTP::Get.new(url.to_s)
	res = Net::HTTP.start(url.host, url.port) {|http|
		http.request(req)
	}
  
	# Convert to JSON
	data = JSON[res.body]

	# Update the dashboard
	send_event("linechart-data", users_count: data)

end
