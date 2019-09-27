# frozen_string_literal: true

require 'require_all'

require_rel '../api-consumers'

trap('INT') do
  puts
  puts 'Exiting, bye!'
  exit
end

StorageConsumer.new.start if ARGV && ARGV[0] == 'start'
