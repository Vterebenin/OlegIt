# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application
Tmdb::Api.key("4064d13e9116b37aae49a206632207e9")
Tmdb::Api.language("en")
