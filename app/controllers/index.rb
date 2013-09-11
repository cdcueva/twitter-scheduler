get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end


get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  oauth_token_secret = @access_token.params[:oauth_token_secret]
  oauth_token = @access_token.params[:oauth_token]
  screen_name = @access_token.params[:screen_name]

  User.create(username: screen_name, oauth_token: oauth_token, oauth_secret: oauth_token_secret)
  puts "hi"
  p @user = User.find_by_username(screen_name) 
  # at this point in the code is where you'll need to create your user account and store the access token


  
  erb :tweet_page
  
end

get '/status/:job_id' do
  job_is_complete(params[:job_id]).to_s
end

post '/tweet/:id' do
  @user = User.find(params[:id]) 
  # @user.oauth_token
  # client = Twitter::Client.new(:oauth_token => @user.oauth_token, :oauth_token_secret => @user.oauth_secret)
  # client.update(params[:tweet])
  @user.tweet(params[:tweet])
end   

