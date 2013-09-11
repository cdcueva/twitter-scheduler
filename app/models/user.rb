class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def tweet(status)
    tweet = tweets.create!(:status => status)
    TweetWorker.perform_in(1.minutes, TweetWorker.perform_async(tweet.id))
  end 
  
end
