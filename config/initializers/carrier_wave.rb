CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAJRZCDA72FRV37T3A',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'us-east-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'zach-rails-app'                     # required
  config.fog_host       = 'http://#{config.fog_directory}.s3.amazonaws.com'            # optional, defaults to nil
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end