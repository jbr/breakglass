# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_breakglass_session',
  :secret      => '1c9a0d18384db448ff4e17e10127e820345ec452edcc611a877535534e33e36a75aada87b0e64ee8c4fbde8d38e69568c7800c3d5556ab53593112705e505ae9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
