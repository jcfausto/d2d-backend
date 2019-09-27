# frozen_string_literal: true

desc 'Run API Tests'
task :test do
  sh %( redis-server --daemonize yes && \
        RUN_COVERAGE=true bundle exec rspec -fd && \
        redis-cli shutdown )
end
