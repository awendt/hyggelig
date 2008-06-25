class Response < ActiveRecord::Base

  validates_presence_of :name, :rsvp

  belongs_to :event

end
