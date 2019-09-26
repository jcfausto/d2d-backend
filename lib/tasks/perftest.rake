# frozen_string_literal: true

desc 'Run Performance Tests'
task :perftest do
  # benchmark.json contains the json object that will be posted
  # -p means to POST it
  # -H adds an Auth header (could be Basic or Token)
  # -T sets the Content-Type
  # -c is concurrent clients
  # -n is the number of requests to run in the test

  # Note: Due to an issue running ab on OSX, instead of localhost the ip is being used.
  # Ref: https://serverfault.com/questions/236623/receiving-error-apr-socket-connect-invalid-argument-22-when-running-apache

  sh %( curl -X DELETE --header 'Accept: application/json' 'http://127.0.0.1:3000/api/v1/vehicles/67209670-1788-43a6-affb-c18058df1031' )
  sh %( sleep 1 )
  sh %( curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'id=67209670-1788-43a6-affb-c18058df1031' 'http://127.0.0.1:3000/api/v1/vehicles' )
  sh %( sleep 1 )
  sh %( ab -p ./lib/support/benchmark.json -T 'application/json' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: application/json' -c 100 -n 2000 'http://127.0.0.1:3000/api/v1/vehicles/67209670-1788-43a6-affb-c18058df1031/locations' )
end
