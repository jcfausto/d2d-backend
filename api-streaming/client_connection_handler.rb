# frozen_string_literal: true

require 'faye/websocket'
require 'em-hiredis'
require 'logger'

# Class responsible for handling the incoming
# websocket connections. Each ws connection will
# be managed by this class.
# Arguments:
#   env: Rack env parameter
class ClientConnectionHandler
  def initialize(rack_env)
    @rack_env = rack_env
    init_logger!
    init_redis_variables!
  end

  def start
    establish_socket_connection!
    setup_websocket_events
    rack_response
  end

  private

  def establish_socket_connection!
    @ws = Faye::WebSocket.new(@rack_env)
  end

  def setup_websocket_events
    on_open
    on_message
    on_close
  end

  def rack_response
    @ws&.rack_response
  end

  def on_open
    @ws.on :open do |_e|
      @log.info 'WebSocket connection opened'
      subscribe_to_streaming_channel!
      start_listening
    end
  end

  def on_message
    @ws.on :message do |message|
      @log.debug "on :message: #{message}"
    end
  end

  def on_close
    @ws.on :close do |_event|
      @log.info 'Websocket connection closed'

      @log.debug 'PubSub connection closed'
      @pubsub.close_connection
    end
  end

  def init_redis_variables!
    @channel = ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] || 'locations'
    @redis_host = ENV['REDIS_HOST'] || 'localhost'
    @redis_port = ENV['REDIS_PORT'] || 6379
    @redis_pass = ENV['REDIS_PASS'] || nil
  end

  def init_logger!
    ENV['LOG_LEVEL'] ||= 'DEBUG'
    @log = Logger.new(STDOUT, level: ENV['LOG_LEVEL'])
  end

  def subscribe_to_streaming_channel!
    @pubsub = EM::Hiredis::PubsubClient.new(@redis_host,
                                            @redis_port,
                                            @redis_pass).connect
    @pubsub.subscribe(@channel)
    @log.info "Subscribed to channel #{@channel}"
  end

  def start_listening
    @log.info "ClientHandler listening for messages on channel #{@channel}"
    @pubsub.on(:message) do |channel, message|
      @log.debug "message: channel: #{channel}; message: #{message}"
      send(message)
    end
  end

  def send(message)
    @ws.send(message)
  end
end
