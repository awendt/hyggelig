# Be sure to restart your server when you modify this file.

HyggeligOrg::Application.config.session_store :cookie_store, :key => '_hyggelig.org_session'

# ActionController::Base.session = {
#   :key         => '_hyggelig_org_session',
#   :secret      => ENV['SESSION_SECRET'] || "#{File.read(RAILS_ROOT + '/config/session_key_secret')}"
# }

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# HyggeligOrg::Application.config.session_store :active_record_store
