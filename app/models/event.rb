class Event < ActiveRecord::Base

  validates_presence_of :name, :date, :location
  validates_uniqueness_of :name

end
