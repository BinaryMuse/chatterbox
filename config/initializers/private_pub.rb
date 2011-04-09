if Rails.env.production?
  PrivatePub.config[:server]               = ENV["PP_SERVER"]
  PrivatePub.config[:secret_token]         = ENV["PP_TOKEN"]
  PrivatePub.config[:signature_expiration] = nil
end
