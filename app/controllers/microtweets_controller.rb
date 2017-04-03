class MicrotweetsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @tweets = []
    if params[:handle]
      begin
        flash.clear
        @tweets = TwitterAdapter.find_tweets_for(params[:handle])
      rescue Twitter::Error::NotFound
        flash[:error] = "Twitter account does not exist!"
        render :index
      end
    end
  end
end
