namespace :db do
  desc "Run migrations"
  task :generate_schema do
    Sequel.connect(Settings.db.url || Settings.db.to_hash) do |db|
      db.extension :schema_dumper
      schema = db.dump_schema_migration
      File.open('schema.rb', 'w')  { |file| file.write(schema) }
    end
  end
end
