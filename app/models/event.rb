class Event < ActiveRecord::Base

  validates_presence_of :name, :date, :location
  validates_uniqueness_of :name
  validates_exclusion_of :name, :in => %w(new feed response event)

  has_permalink :name, :permalink
  has_many :responses

  def has_responses?
    !self.responses.blank?
  end

  def guests_by_reverse_chron
    responses.sort_by(&:created_at).reverse
  end

end
