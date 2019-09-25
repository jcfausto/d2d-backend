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
