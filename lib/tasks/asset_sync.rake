


Rake::Task["assets:precompile:nondigest"].enhance do
  AssetSync.sync
end