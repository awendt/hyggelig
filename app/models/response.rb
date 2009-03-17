class Response < ActiveRecord::Base

  validates_presence_of :name, :event_id
  validates_associated :event
  validates_inclusion_of :rsvp, :in => [true, false], :message => "^#{I18n.t(:'response.confirm_or_decline')}"
  validates_uniqueness_of :name, :scope => [:event_id], :case_sensitive => false

  belongs_to :event

  default_scope :order => 'created_at DESC'

  def attending?
    rsvp == true
  end
  
  def number_of_guests
    guests = 1
    guests += $1.to_i if name =~ /\+\s?(\d+)/
    guests
  end
  
end
