Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, "eq004itbu3iNPUECSfgfjg", "VqmbAxwPslXY2xq4uTe0SrGp3CW7xrkGjNeeKjdtZw8"
end