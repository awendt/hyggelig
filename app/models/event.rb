class Event < ActiveRecord::Base

  RESERVED_NAMES = %w(events feed replies faq faqs demo help tour).freeze
  TIME_TO_LIVE = 60.days
  attr_readonly :expires_on

  validates_presence_of :name, :date, :location
  validates_each :name do |record, attr, value|
    record.errors.add attr, I18n.t(:'activerecord.errors.messages.exclusion') \
      if value && RESERVED_NAMES.include?(value.downcase)
  end
  validates_length_of :name, :minimum => 3

  has_permalink :name, :permalink
  has_many :replies, :dependent => :delete_all

  scope :expired, where("expires_on < ?", Date.today)

  before_create :set_ttl

  def has_replies?
    !self.replies.blank?
  end

  def set_ttl
    write_attribute(:expires_on, TIME_TO_LIVE.from_now.to_date)
  end

  def to_xml
    super(:except => [:id])
  end

  def to_json
    super(:except => [:id])
  end

end
