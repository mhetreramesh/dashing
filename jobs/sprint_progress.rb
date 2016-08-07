require 'jira'

SCHEDULER.every '5m', :first_in => 0 do |job|
  client = JIRA::Client.new({
    :username => ENV['ramesh.mhetre '],
    :password => ENV['Ramesh@12'],
    :site => "https://vegfru.atlassian.net",
    :auth_type => :basic,
    :context_path => ""
  })

  closed_points = client.Issue.jql("sprint in openSprints() and status = \"closed\"").map{ |issue| issue.fields['customfield_10004'] }.reduce(:+) || 0
  total_points = client.Issue.jql("sprint in openSprints()").map{ |issue| issue.fields['customfield_10004'] }.reduce(:+) || 0
  if total_points == 0
    percentage = 0
    moreinfo = "No sprint currently in progress"
  else
    percentage = ((closed_points/total_points)*100).to_i
    moreinfo = "#{closed_points.to_i} / #{total_points.to_i}"
  end

  send_event('Vegfru_Sprint_Id', { title: "Sprint Progress", min: 0, value: percentage, max: 100, moreinfo: moreinfo })
end
