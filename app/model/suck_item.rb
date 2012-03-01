class SuckItem < ActiveRecord::Base
  @@suck_popular = 20
  @@suck_retire = 125
  @@suck_stagnant = 100
  #:has_many  iplog
  validates_uniqueness_of  :name
  validates_presence_of :name

  def vote
    # If you vote, the stagnation goes back to zero
#    @stagnation = 0
  end

  def is_retired?
    return true if @stagnation > @@suck_stagnant
    false
  end

end
