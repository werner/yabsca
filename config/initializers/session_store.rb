# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_yabsca_extjs_session',
  :secret      => '703c4986f91e05a9c23b4c7aaea6436608c396a3868c2ebdcac0a48a6eff3dd32297420562cd3595af929e583eadf433f74213c9537b0bf1409348088ed31c48'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
