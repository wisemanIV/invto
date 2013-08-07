CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = Rails.root.join('tmp')

  config.storage = :fog
  config.fog_credentials = {
    :provider           => 'Rackspace',
    :rackspace_username => ENV["RACKSPACE_USERNAME"],
    :rackspace_api_key  => ENV["RACKSPACE_API_KEY"],
    :rackspace_region   => :ord                # optional, defaults to :dfw
  }
  config.fog_directory = 'inviter'
  config.asset_host = 'http://a78a8e25849943c71c13-a57d35364126db633f9d675e21f31d77.r99.cf2.rackcdn.com'
  config.enable_processing = true
end