
require 'rubygems'
require 'active_record'

require 'awesome_print'
DB_ENV='test'

ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml'))[DB_ENV])
ActiveRecord::Base.logger = Logger.new(File.open('logs/database.log', 'a'))
ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true

#$LOAD_PATH.push 'app/model'

require 'app/model/suck_item'

#a = SuckItem.find(:first)
SuckItem.find(:all, :conditions => {:name => "AIX"}).each do | item|
  ap item
  item.points = item.points - 1
  item.save
end


#puts item.is_retired?
#ap SuckItem.methods.sort
#p a
#p a.find_all(:fisrt)




# Attempt to find a suck record
# Create a new suck record
# Vote on a suck record
#
#  Determine if it is below retire threashold
