require 'twitter'


#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
twitter = Twitter::REST::Client.new do |config|
  config.consumer_key = 'QJv3Mn7HHLf4YSLRyNed7eCpN'
  config.consumer_secret = 'ZaRjuu4D0nTFZIYMohi8opRt6IdTrAbcCJW5UZM0zfPURqZIM4'
  config.access_token = '434845940-F4ffJaa4px1cOanBhnEvw5zCstRpC6oG9lkH3pP1'
  config.access_token_secret = 'I9SF2ssnTmmpOVDUIzktq7LdqUTby4KIYVlrvvAZzgEiB'
end

search_term = URI::encode('@mhetreramesh')

SCHEDULER.every '10m', :first_in => 0 do |job|
  begin
    tweets = twitter.search("#{search_term}")

    if tweets
      tweets = tweets.map do |tweet|
        { name: tweet.user.name, body: tweet.text, avatar: tweet.user.profile_image_url_https }
      end
      send_event('twitter_mentions', comments: tweets)
    end
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  end
end