

require 'rubygems'
#require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql',
  :database => 'newsuck',
  :username => 'root',
  :password => '',
  :host     => 'localhost')



