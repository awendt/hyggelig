class Event < ActiveRecord::Base

  RESERVED_NAMES = %w(new event feed response faq faqs demo help tour).freeze
  TIME_TO_LIVE = 60.days
  attr_readonly :expires_on

  validates_presence_of :name, :date, :location
  validates_each :name do |record, attr, value|
    record.errors.add attr, I18n.t(:'active_record_messages.exclusion') \
      if value && RESERVED_NAMES.include?(value.downcase)
  end
  validates_length_of :name, :minimum => 3

  has_permalink :name, :permalink
  has_many :responses, :dependent => :delete_all

  named_scope :expired, :conditions => ["expires_on < ?", Date.today]

  def has_responses?
    !self.responses.blank?
  end

  def before_create
    write_attribute(:expires_on, TIME_TO_LIVE.from_now.to_date)
  end

end
