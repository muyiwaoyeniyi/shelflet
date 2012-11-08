=begin
Rake::Task['assets:precompile'].enhance do
  AssetSync.sync
end


Rake::Task["assets:precompile:nondigest"].enhance do
  AssetSync.sync
end
=end

=begin
desc "deploys to heroku after uploading assets to S3"
task deploy: [:environment, 'assets:precompile'] do
  puts `git push heroku`
  puts `rake assets:clean`
end
=end