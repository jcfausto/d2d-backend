# frozen_string_literal: true

desc 'Run API Tests'
task :test do
  exec 'RUN_COVERAGE=true bundle exec rspec -fd'
end
