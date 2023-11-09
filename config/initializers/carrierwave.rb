require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory = ENV.fetch('S3_BUCKET_NAME', nil)
    config.fog_public = false
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV.fetch('S3_ACCESS_KEY_ID', nil),
      aws_secret_access_key: ENV.fetch('S3_SECRET_ACCESS_KEY', nil),
      region: 'ap-northeast-1',
      path_style: true,
    }
  else
    config.storage = :file
    config.cache_storage = :file
    config.store_dir = 'uploads'
    config.enable_processing = false if Rails.env.test?
    config.asset_host = "http://localhost:3000"
  end
end
