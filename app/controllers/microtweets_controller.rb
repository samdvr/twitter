class MicrotweetsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tweets = []
    if params[:handle]
      begin
        flash.clear
        @tweets = ::TwitterAdapter.find_tweets_for(params[:handle])
      rescue Twitter::Error::NotFound
        flash[:error] = "Twitter account does not exist!"
        render :index
      end
    end
  end
end

class TwitterAdapter
  def self.find_tweets_for(handle)
    Rails.cache.fetch(handle, expires_in: 5.minutes) do
      TwitterClient.user_timeline(handle, count: 25)
    end
  end
end
