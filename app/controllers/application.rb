# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  extend ActiveSupport::Memoizable

  include ExceptionNotifiable
  
  before_filter :drop_subdomain_if_duplicates_accept_language_header
  before_filter :set_locale
  
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'b4de00879214a2600e5c809da93ff000'
  
private

  def drop_subdomain_if_duplicates_accept_language_header
    if (client_accepted_languages.first(1) == locale_in_subdomain)
      redirect_to(:subdomain => false)
      return false
    end
    true
  end

  def set_locale
    lang_intersection = prefered_langs & available_locales
    if lang_intersection.empty?
      I18n.locale = :en
    else
      I18n.locale = lang_intersection.first
    end
    true
  end

  def prefered_langs
    locale_in_subdomain + client_accepted_languages
  end

  def locale_in_subdomain
    [current_subdomain].compact.map(&:to_sym)
  end

  def client_accepted_languages
    parse_http_accept_language_header(request.env["HTTP_ACCEPT_LANGUAGE"])
  end

  def parse_http_accept_language_header(header)
    return [] unless header
    # assumes the languages are ordered by quality value
    # (see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.4)
    http_accept_langs = header.split(/,/)

    # strip qvalues
    http_accept_langs.collect! { |lang| lang.split(/;/).first.split(/-/).first }

    http_accept_langs.uniq.map(&:to_sym)
  end
  memoize :parse_http_accept_language_header

  def available_locales
    Dir["config/locales/*.yml"].map { |file| File.basename(file, ".yml").to_sym }
  end
  memoize :available_locales
  helper_method :available_locales

end
