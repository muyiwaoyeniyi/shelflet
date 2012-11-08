
AssetSync.configure do |config|
  config.fog_provider = 'AWS'
  config.aws_access_key_id = ENV['AKIAIWELXR6XA3HLAB5A']
  config.aws_secret_access_key = ENV['g/4ANKSeudNU1IuUos28BRlRi7VghFJ7jaByrqOW']
  config.fog_directory = ENV['shelflet_photos_prod']
  
  # Increase upload performance by configuring your region
  # config.fog_region = 'eu-west-1'
  #
  # Don't delete files from the store
  # config.existing_remote_files = "keep"
  #
  # Automatically replace files with their equivalent gzip compressed version
  config.gzip_compression = true
  #
  # Use the Rails generated 'manifest.yml' file to produce the list of files to 
  # upload instead of searching the assets directory.
  # config.manifest = true
  #
  # Fail silently.  Useful for environments such as Heroku
  # config.fail_silently = true
end
