Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, "eq004itbu3iNPUECSfgfjg", "VqmbAxwPslXY2xq4uTe0SrGp3CW7xrkGjNeeKjdtZw8"
  #provider :facebook, APP_ID, APP_SECRET, {:scope => 'publish_stream,offline_access,email'}
  end
  
  Twitter.configure do |config|
    config.consumer_key = "eq004itbu3iNPUECSfgfjg"
    config.consumer_secret = "VqmbAxwPslXY2xq4uTe0SrGp3CW7xrkGjNeeKjdtZw8"
    config.oauth_token = "48857695-eAu3ktvpWlBN7baoa7YDcz9pmvJ47q5PN4fWSh00"
    config.oauth_token_secret = "TthA67ToQUqMYVusoeKdkUUpUzYpUWRU3u9wkx2MLyc"
  
end