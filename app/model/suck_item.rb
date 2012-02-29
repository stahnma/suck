class SuckItem < ActiveRecord::Base
  #:has_many  iplog
  validates_uniqueness_of  :name
  validates_presence_of :name
end
