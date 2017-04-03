class TwitterAdapter
  def self.find_tweets_for(handle)
  	Rails.cache.fetch(handle, expires_in: 5.minutes) do
      TwitterClient.user_timeline(handle, count: 25)
    end
  end
end