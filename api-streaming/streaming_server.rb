# frozen_string_literal: true

require 'em-websocket'
require 'em-hiredis'
require 'logger'

# API Streaming Server
class StreamingServer
  def initialize
    set_logger!
  end

  def start
    @log.info 'Streaming server starting...'
    ENV['STREAMING_SERVER_WS_HOST'] ||= '0.0.0.0'
    ENV['STREAMING_SERVER_WS_PORT'] ||= 9292

    EM.run do
      EM::WebSocket.start(host: ENV['STREAMING_SERVER_WS_HOST'],
                          port: ENV['STREAMING_SERVER_WS_PORT']) do |ws|
        setup_events_for(ws)
      end
    end
  end

  private

  def setup_events_for(websocket)
    on_open(websocket)
    on_message(websocket)
    on_close(websocket)
  end

  def on_open(websocket)
    websocket.onopen do
      @log.info 'WebSocket connection opened'
      subscribe_to_redis!
      start_message_streaming(websocket)
    end
  end

  def on_message(websocket)
    websocket.onmessage do |message|
      @log.debug "onmessage: #{message}"
    end
  end

  def on_close(websocket)
    websocket.onclose do
      @log.info 'WebSocket connection closed'
    end
  end

  def set_logger!
    ENV['LOG_LEVEL'] ||= 'ERROR'
    @log = Logger.new(STDOUT, level: ENV['LOG_LEVEL'])
  end

  def subscribe_to_redis!
    ENV['VEHICLE_LOCATION_REDIS_CHANNEL'] ||= 'locations'
    @redis = EM::Hiredis.connect
    @pubsub = @redis.pubsub
    @pubsub.subscribe(ENV['VEHICLE_LOCATION_REDIS_CHANNEL'])
  end

  def start_message_streaming(websocket)
    @pubsub.on(:message) do |channel, message|
      @log.debug "message: channel: #{channel}; message: #{message}"
      websocket.send(message)
    end
  end
end
