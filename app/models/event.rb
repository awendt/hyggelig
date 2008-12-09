class Event < ActiveRecord::Base

  RESERVED_NAMES = %w(new event feed response faq faqs demo help).freeze
  validates_presence_of :name, :date, :location
  validates_each :name do |record, attr, value|
    record.errors.add attr, Localization.entry(:active_record_messages, :exclusion) \
      if value && RESERVED_NAMES.include?(value.downcase)
  end

  has_permalink :name, :permalink
  has_many :responses, :dependent => :delete_all

  def has_responses?
    !self.responses.blank?
  end

  def guests_by_reverse_chron
    responses.sort_by(&:created_at).reverse
  end

end
