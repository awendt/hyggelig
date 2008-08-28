class Response < ActiveRecord::Base

  validates_presence_of :name, :event_id
  validates_associated :event
  validates_inclusion_of :rsvp, :in => [true, false], :message => "^#{l(:response, :confirm_or_decline)}"
  validates_uniqueness_of :name, :scope => [:event_id]

  belongs_to :event
  
  def attending?
    rsvp == true
  end
  
end
