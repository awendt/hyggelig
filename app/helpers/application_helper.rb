# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  extend ActiveSupport::Memoizable

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
      I18n.t(message, :item => link_to(*item))
    else
      I18n.t(message, :item => item)
    end
  end

  def error_messages_header_for(*params)
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

  def error_messages_body_for(*params)
    options = params.extract_options!.symbolize_keys

    if object = options.delete(:object)
      objects = [object].flatten
    else
      objects = params.collect {|object_name| instance_variable_get("@#{object_name}") }.compact
    end

    count  = objects.inject(0) {|sum, object| sum + object.errors.count }
    unless count.zero?
      options[:object_name] ||= params.first

      I18n.with_options :locale => options[:locale], :scope => [:activerecord, :errors, :template] do |locale|
        error_messages = objects.sum {|object| object.errors.full_messages.map {|msg| content_tag(:li, msg) } }.join

        content_tag(:div, content_tag(:ul, error_messages), :id => 'errors')
      end
    else
      ''
    end
  end

  def label_with_hint(object_name, method, text = nil, hint = nil, options = {})
    text_with_hint = "#{text}"
    text_with_hint += tag(:br)
    text_with_hint += content_tag(:span, hint, :class => 'hint', :id => :"#{object_name}_#{method}_hint")
    label object_name, method, text_with_hint, options
  end

  def links_for_other_locales
    links = []
    other_locales = I18n.available_locales - [I18n.locale]
    other_locales.each do |locale|
      links << link_to(I18n.t(:language, :locale => locale), :locale => locale)
    end
    links.join(' &#8212; ')
  end
  memoize :links_for_other_locales

  def page_title
    if controller.action_name == "new"
      "#{SITE_NAME} | #{I18n.t(:slogan)}"
    elsif @event
      "#{@event.name}, #{@event.date} | #{SITE_NAME}"
    elsif @title
      @title
    else
      SITE_NAME
    end
  end

  def rails_env
    RAILS_ENV
  end

  def piwik_tracker_code
    if rails_env == "production"
      <<-EOS
      <script type="text/javascript">
      var pkBaseURL = (("https:" == document.location.protocol) ? "https://p.wendtswelt.de/" : "http://p.wendtswelt.de/");
      document.write(unescape("%3Cscript src='" + pkBaseURL + "piwik.js' type='text/javascript'%3E%3C/script%3E"));
      </script><script type="text/javascript">
      try {
      var piwikTracker = Piwik.getTracker(pkBaseURL + "piwik.php", 1);
      piwikTracker.trackPageView();
      piwikTracker.enableLinkTracking();
      } catch( err ) {}
      </script><noscript><p><img src="http://p.wendtswelt.de/piwik.php?idsite=1" style="border:0" alt=""/></p></noscript>
      EOS
    else
      ""
    end
  end
end
