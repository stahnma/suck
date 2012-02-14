
require 'rubygems'
require 'active_record'
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
