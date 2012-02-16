
require 'rubygems'
require 'active_record'
require 'active_record/fixtures'
require 'erb'
require 'yaml'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql',
  :database => 'newsuck',
  :username => 'root',
  :password => '',
  :host     => 'localhost')

  @logger = Logger.new $stderr
  ActiveRecord::Base.logger = @logger
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true


namespace :db do
  desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
  task :migrate do
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
 # ActiveRecord::Base.establish_connection(YAML::load(File.open('database.yml')))
 # ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end

