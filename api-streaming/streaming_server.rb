# frozen_string_literal: true

require 'faye/websocket'
require 'em-hiredis'
require 'logger'

# API Streaming Server
class StreamingServer
  def initialize(env)
    @env = env
    @channel = ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] || 'locations'
    @redis_host = ENV['REDIS_HOST'] || 'localhost'
    @redis_port = ENV['REDIS_PORT'] || 6379
    set_logger!
  end

  def start
    @log.info 'Streaming server starting...'
    @ws = Faye::WebSocket.new(@env)
    setup_events_for(@ws)
  end

  def rack_response
    @ws&.rack_response
  end

  private

  def setup_events_for(_websocket)
    on_open
    on_message
    on_close
  end

  def on_open
    @ws.on :open do |_e|
      @log.info 'WebSocket connection opened'
      subscribe_to_redis!
      start_message_streaming
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

  def set_logger!
    ENV['LOG_LEVEL'] ||= 'DEBUG'
    @log = Logger.new(STDOUT, level: ENV['LOG_LEVEL'])
  end

  def subscribe_to_redis!
    @log.info "Subscribing to Redis: #{@redis_host}:#{@redis_port} "
    @pubsub = EM::Hiredis::PubsubClient.new(@redis_host, @redis_port).connect
    @pubsub.subscribe(@channel)
  end

  def start_message_streaming
    @pubsub.on(:message) do |channel, message|
      @log.debug "message: channel: #{channel}; message: #{message}"
      @ws.send(message)
    end
  end
end
