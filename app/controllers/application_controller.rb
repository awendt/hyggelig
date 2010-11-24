# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  before_filter :set_locale

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'b4de00879214a2600e5c809da93ff000'

private

  def set_locale
    lang_intersection = prefered_langs & I18n.available_locales
    if lang_intersection.empty?
      I18n.locale = :en
    else
      I18n.locale = lang_intersection.first
    end
    I18n.default_locale = client_accepted_languages.first || :en
    true
  end

  def prefered_langs
    params[:locale].to_a.map(&:to_sym) + client_accepted_languages
  end

  def prevent_modifications
    respond_to do |format|
      format.html do
        redirect_to(root_path)
      end
      format.xml { render :xml => {:errors => {:error => "This action is not allowed"}}, :status => :forbidden }
    end
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    params[:locale] ? { :locale => I18n.locale } : {}
  end
end
