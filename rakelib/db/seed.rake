namespace :db do
  desc "Run seeds"
  task :seed, [:version] do |t, args|
    require "sequel/core"
    require 'sequel/extensions/seed'
    require_relative '../../config/environment.rb'

    Sequel.connect(Settings.db.to_hash) do |db|
      Sequel.extension :seed
      env = ENV['RACK_ENV'] ||= 'development'
      Sequel::Seed.setup(env.to_sym)

      Sequel::Seeder.apply(db, "db/seeds")
    end

    Rake::Task['db:generate_schema'].execute
  end

end