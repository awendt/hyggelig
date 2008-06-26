class Response < ActiveRecord::Base

  validates_presence_of :name, :rsvp, :event_id
  validates_associated :event

  belongs_to :event

end
