# frozen_string_literal: true

desc 'Start the APIs'
task :start do
  sh %( rackup --port 3000 -o 0.0.0.0 )
end
