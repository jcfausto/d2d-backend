# frozen_string_literal: true

desc 'Run API Tests'
task :test do
  exec "redis-server --daemonize yes > /dev/null && \
        RUN_COVERAGE=true bundle exec rspec -fd &&  \
        redis-cli shutdown > /dev/null"
end
