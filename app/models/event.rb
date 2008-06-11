class Event < ActiveRecord::Base

  validates_presence_of :name, :date, :location

  attr_accessor :name, :date, :location

end
