unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: 'AKIASYAWOYNJ6VVATN67',
      aws_secret_access_key: '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',
      region: 'us-east-1'
    }
    
    config.fog_public = false
    config.fog_directory  = 'production-guilds'
    config.cache_storage = :fog
  end
end