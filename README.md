# door2door Backend Exercise

## APIs

*Design Principles*

	- Well documented. Documentation as a Code (OpenAPI/Swagger).
	- Well tested. TDD.
	- Linted (Rubocop, eslint).
	- Performant (non-blocking, no I/O)
	- Observable (logs, metrics, tracing?)
  - Decoupling Writes from Reads (CQRS like)
	  - Location service will only write location updates.
	  - Streaming service will only read location updates and will stream them to clients (Firehose).
	  - Location will not hold state.
	  - Streaming will not hold state (fire-and-forget).
	  - State will be hold by an in-memory DB (Redis).

### Vehicle Registry API

Registration / De-Registration
	- It's like a session. It starts when the V asks for registration, is deleted when the V is de-registered. (Redis is good to handle sessions).

### Vehicle Location API

Location updates
	- Vehicles will report location every 3 seconds.
	- Only registered vehicles will send updates.
	- Valid location updates need to have navigation bearing added to the notification object.
	- Valid location updates need to be streamed to clients as real-time as possible.
	- Valid location updates need to be stored for later consumption by an analytics tool.
	- Invalid location updates should be disregarded.
	- It's basically JSON objects (No need for a relational DB).

### Location Streaming API

Will stream location updates to connected clientes using WebSockets?

## Dependencies

- Redis

## Infrastructure

Infrastructure
	- Dockerized solution (which could run later on a K8s cluster for instance).
	- Deployed on Heroku (as an alternative).

### Run on Docker

```bash
$ docker-compose build # to build the image
$ docker-compose up    # to start the container
```

or

```bash
$ docker-compose up --build # to build the image and start
                            # the container right after the build.
```

### Rake Tasks

#### Start the server

```bash
rake start
```

#### Run API tests

```bash
rake test
```

#### Run API Performance Tests

Performance tests using Apache Benchmark can be done by executing the command below:

```bash
rake perftest
```

Default parameters are: 2000 requests being made by 100 concurrent clients. Each client will fire 20 request and they'll do that in parallel.

Sample output:

This is ApacheBench, Version 2.3 <$Revision: 1826891 $>
Copyright 1996 Adam Twiss, Zeus Technology Ltd, http://www.zeustech.net/
Licensed to The Apache Software Foundation, http://www.apache.org/

Benchmarking 127.0.0.1 (be patient)
Completed 200 requests
Completed 400 requests
Completed 600 requests
Completed 800 requests
Completed 1000 requests
Completed 1200 requests
Completed 1400 requests
Completed 1600 requests
Completed 1800 requests
Completed 2000 requests
Finished 2000 requests


Server Software:
Server Hostname:        127.0.0.1
Server Port:            3000

Document Path:          /api/v1/vehicles/67209670-1788-43a6-affb-c18058df1031/locations
Document Length:        0 bytes

Concurrency Level:      100
Time taken for tests:   2.303 seconds
Complete requests:      2000
Failed requests:        0
Total transferred:      54000 bytes
Total body sent:        668000
HTML transferred:       0 bytes
Requests per second:    868.46 [#/sec] (mean)
Time per request:       115.146 [ms] (mean)
Time per request:       1.151 [ms] (mean, across all concurrent requests)
Transfer rate:          22.90 [Kbytes/sec] received
                        283.27 kb/s sent
                        306.17 kb/s total

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.4      0       3
Processing:    16  112  18.8    110     184
Waiting:       14  110  18.7    108     181
Total:         19  112  18.7    110     184

Percentage of the requests served within a certain time (ms)
  50%    110
  66%    116
  75%    120
  80%    124
  90%    135
  95%    146
  98%    155
  99%    166
 100%    184 (longest request)

### Pre-commit hook

There's a pre-commit hook that will lint the project and will test it before allowing the commit.

If you're not using pre-commit hooks yet, after cloning this repo, execute the command below:

```bash
$ cp pre-commit .git/hooks/
```

If you're using pre-commit hooks already, copy the content of the pre-commit into your .git/hooks/pre-commit hook file.

# Notes (WIP)

Namespaces in Redis - This will keep data organized and easy to query.
	- registry - Containing the registered vehicles.
		○ Ex: registry:"vehicle":"abc123"
	- position - Containing the last reported vehicle position
