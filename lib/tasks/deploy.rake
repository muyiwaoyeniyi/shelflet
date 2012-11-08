=begin
Rake::Task['assets:precompile'].enhance do
  AssetSync.sync
end


Rake::Task["assets:precompile:nondigest"].enhance do
  AssetSync.sync
end
=end

#ENV['AWS_ACCESS_KEY'] = 'AKIAIWELXR6XA3HLAB5A'
#ENV['AWS_ACCESS_SECRET'] = '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'
#ENV['AWS_BUCKET'] = 'shelflet_photos_prod'


desc "deploys to heroku after uploading assets to S3"
task deploy: [:environment, 'assets:precompile'] do
  puts `git push heroku`
  puts `rake assets:clean`
end