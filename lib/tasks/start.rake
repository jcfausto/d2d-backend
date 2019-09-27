# frozen_string_literal: true

namespace :start do
  desc 'Start the APIs'
  task :api do
    sh %( rackup --port 3000 -o 0.0.0.0 )
  end

  desc 'Start the API consumers'
  task :consumers do
    sh %( ruby ./api-consumers/init.rb start )
  end
end

desc 'Default task: start:api'
task :start do
  sh %( rackup --port 3000 -o 0.0.0.0 )
end
