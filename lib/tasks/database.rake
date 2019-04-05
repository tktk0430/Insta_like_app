namespace :db do
  desc "Rebuild the development database from scratch"
  task :rebuild => :environment do
    Rake::Task["db:migrate:reset"].invoke
    Rake::Task["db:migrate"].invoke
    Rake::Task["db:seed"].invoke
  end
end