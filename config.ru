# frozen_string_literal: true

# Start with warnings enabled and on port 3000
#\ -w -p 3000 -b tcp://127.0.0.1:3000

require File.expand_path('./config/environment', __dir__)

# Swagger-UI for seeing the API spec
use Rack::Static,
  root: File.expand_path('./swagger-ui', __dir__),
  urls: ["/css","/fonts","/images","/lang","/lib"],
  index: 'index.html'

run API::Base
