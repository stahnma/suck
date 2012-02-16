
require 'rubygems'
require 'active_record'
require 'active_record/fixtures'
require 'erb'
require 'yaml'

#  @logger = Logger.new $stderr
#  ActiveRecord::Base.logger = @logger

if ENV.has_key? 'db_env'
  DB_ENV = ENV['db_env'] 
else
  DB_ENV = 'test'
end

namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate =>  :environment  do
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end

desc "Load fixtures into the current database.  Load specific fixtures using FIXTURES=x,y"
task :fixtures => :environment do
  fixtures = ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : Dir.glob(File.join(File.dirname(__FILE__), 'test', 'fixtures', '*.{yml,csv}'))
  fixtures.each do |fixture_file|
    Fixtures.create_fixtures('test/fixtures', File.basename(fixture_file, '.*'))
  end
end

task :environment do
 ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))[DB_ENV])
 ActiveRecord::Base.logger = Logger.new(File.open('logs/database.log', 'a'))
 ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
end

desc "Migrate and install fixtures into a database"
task :setup => [ "db:migrate", :fixtures ] do
end

desc "Retrieves the current schema version number"
task :version => :environment do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end
