# frozen_string_literal: true

require_relative './client_connection_handler'
require 'faye/websocket'

Server = lambda do |env|
  if Faye::WebSocket.websocket?(env)
    ClientConnectionHandler.new(env).start
  else
    [200, { 'Content-Type' => 'application/json' }, ['{"status":"healthy"}']]
  end
end
