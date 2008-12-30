# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  FLASH_NOTICE_KEYS = [:error, :notice, :warning]

  def flash_messages # see http://rubypond.com/articles/2008/07/11/useful-flash-messages-in-rails/
    return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
    formatted_messages = messages.map do |type|
      content_tag :p, :id => "flash_#{type}", :class => 'flash' do
        message_for_item(flash[type], flash["#{type}_item".to_sym])
      end
    end
    formatted_messages.join
  end

  def message_for_item(message, item = nil)
    if item.is_a?(Array)
      message % link_to(*item)
    else
      message % item
    end
  end

  def short_error_message_for(*params)
    options = params.extract_options!.symbolize_keys

    if object = options.delete(:object)
      objects = [object].flatten
    else
      objects = params.collect {|object_name| instance_variable_get("@#{object_name}") }.compact
    end

    count  = objects.inject(0) {|sum, object| sum + object.errors.count }
    unless count.zero?
      options[:object_name] ||= params.first

      I18n.with_options :scope => [:activerecord, :errors, :template] do |locale|
        object_name = options[:object_name].to_s.gsub('_', ' ')
        object_name = I18n.t(object_name, :default => object_name, :scope => [:activerecord, :models], :count => 1)
        header_message = locale.t :header, :count => count, :model => object_name

        content_tag(:div, header_message, :id => 'errors')
      end
    else
      ''
    end
  end

end
