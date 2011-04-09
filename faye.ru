# Run with: rackup faye.ru -s thin -E production
require "yaml"
require "faye"
begin
  require "private_pub"
rescue LoadError
  require "bundler/setup"
  require "private_pub"
end

config_file = File.expand_path("../config/private_pub.yml", __FILE__)

if File.exist? config_file
  PrivatePub.load_config(config_file, ENV["RAILS_ENV"] || "development")
else
  PrivatePub.config[:server]               = ENV["PP_SERVER"]
  PrivatePub.config[:secret_token]         = ENV["PP_TOKEN"]
  PrivatePub.config[:signature_expiration] = nil
end
run Faye::RackAdapter.new(:mount => "/faye", :timeout => 25, :extensions => [PrivatePub.faye_extension])
