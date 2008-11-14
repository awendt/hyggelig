# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  FLASH_NOTICE_KEYS = [:error, :notice, :warning]

  def flash_messages # see http://rubypond.com/articles/2008/07/11/useful-flash-messages-in-rails/
    return unless messages = flash.keys.select{|k| FLASH_NOTICE_KEYS.include?(k)}
    formatted_messages = messages.map do |type|
      content_tag :p, :id => "flash" do
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

end
