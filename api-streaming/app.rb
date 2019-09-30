# frozen_string_literal: true

require_relative './streaming_server'
require 'faye/websocket'

App = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    @server = StreamingServer.new(env)
    @server.start
    @server.rack_response
  elsif env['REQUEST_PATH'] == '/'
    Rack::Response.new(File.read('./api-streaming/public/index.html'),
                       200,
                       'Content-Type' => 'text/html')
  else
    [200, { 'Content-Type' => 'application/json' }, ['{"status":"healthy"}']]
  end
end
