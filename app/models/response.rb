class Response < ActiveRecord::Base

  validates_presence_of :name, :event_id
  validates_associated :event
  validates_inclusion_of :rsvp, :in => [true, false]
  validates_uniqueness_of :name, :scope => [:event_id]

  belongs_to :event

end