# door2door Backend Exercise

## Goals

1. Collect the location and compute the navigation bearing of all vehicles in real-time.
2. Broadcast the location & bearing updates of all vehicles to connected clients, like web or mobile applications.

[Full spec here](https://github.com/door2door-io/d2d-code-challenges/tree/master/backend)

## Solution

The solution is composed by 5 components.

- Vehicles API
- Config API
- Storage Consumer
- Streaming Server
- Web Client

### Overview

![alt text](docs/images/solution-overview.png)

#### Tech Stack

- Language: Ruby 2.6.3
- Frameworks:
	- Grape: for the API.
- Technologies
	- Redis: for the store and pub/sub mechanism.
	- MongoDB: for the permanent storage.
	- WebSockets: for the Streaming Server.
  - React: for the frontend.

## APIs

### Vehicles API

[Live demo on heroku](https://d2d-backend-api.herokuapp.com)

**Version:** 1

[API Specification](https://d2d-backend-api.herokuapp.com)

This API offers the following services:

- Vehicle registration / de-registration.
- Vehicle location update.

**Supported Operations**

| Verb | Endpoint | Payload | Response | Description |
| -----------| --------------|----|----|------------ |
| GET | /api/v1/vehicles/health || status: 200 / body: {"status":"OK"} | Healthcheck |
| POST | /api/v1/vehicles	| ```{"id":"some-uuid"}``` | status: 204 / body: No content | Registers a vehicle |
| DELETE | /api/v1/vehicles/:uuid	|| status: 204 / body: No content | De-registers a vehicle |
| POST | /api/v1/vehicles/:uuid/locations	|```{"lat":52.53, "lng":13.403, "at":"2019-09-30T10:22:23+0200", "id":"some-uuid"}```| status: 204 / body: No content | Receive vehicle location updates |

### Config API

[Live demo on heroku](https://d2d-backend-api.herokuapp.com)

**Version:** 1

[API Specification](https://d2d-backend-api.herokuapp.com)

This API provides access to the service configuration parameters to clients.

**Supported Operations**

| Verb | Endpoint | Payload | Response | Description |
| -----------| --------------|----|----|------------ |
| GET | /api/v1/config || status: 200 / body: {"centralPoint": {"lat": 52.53, "lng": 13.403}, "limitRadiusInKm": 3.5} | Service Operation Parameters |


### Web Client

[Demo on heroku](https://d2d-dashboard.herokuapp.com)

A web client interface where you'll be able to visualize active vehicles (those with valid positions), their heading and the operation parameters currently applied to the system.

### Streaming Server

[Demo on heroku](https://d2d-backend-streaming-server.herokuapp.com)

WebSocket server that streams vehicle location updates to connected clients.

JSON Objects are streamed to clients according to the following schema:

[Location Update JSON Schema](spec/support/api/schemas/location_update.json)

```json
{
  "type": "object",
  "required": ["lat", "lng", "bearing", "at", "vehicle_id"],
  "properties": {
    "lat": { "type":"number" },
    "lng": { "type":"number" },
    "bearing": { "type":"number" },
    "at": { "type":"string" },
    "vehicle_id": { "type":"string" }
  }
}
```

Example:

```javascript
// Client validation (Browser)
// <script src="https://cdn.jsdelivr.net/npm/json-schema@0.2.5/lib/validate.min.js"></script>

const schema = {
  "type": "object",
  "required": ["lat", "lng", "bearing", "at", "vehicle_id"],
  "properties": {
    "lat": { "type":"number" },
    "lng": { "type":"number" },
    "bearing": { "type":"number" },
    "at": { "type":"string" },
    "vehicle_id": { "type":"string" }
  }
};

let webSocket = new WebSocket('ws://127.0.0.1:9292/');

webSocket.onmessage = (event) => {
  var location = JSON.parse(event.data);
  console.log(jsonSchema.validate(location, schema));
}
```

## Setup

## Docker

```bash
$ docker-compose build # to build the images
$ docker-compose up    # to start the services (-d to start in daemon mode)
```

## Local

### Pre-requisites
- Redis
- MongoDB

### Instalation

#### Backend

```bash
$ git clone https://github.com/jcfausto/d2d-backend.git
$ cd d2d-backend
$ bundle install
```

#### Frontend

Note: Available at ```/public/frontend/```.

```bash
$ cd public/frontend
# To install the packages
$ yarn
```

### Testing

Notes:
- Make sure you have MongoDB running on your machine at ```localhost:27017```.
- During tests, redis-server will start and stop.


To make sure everything works fine, please run the tests before running the services.

```bash
$ rake test
```

### Running

Notes:
- Make sure you have Redis running and available at ```localhost:6379```
- You'll need 4 terminal windows for running the application.

```bash
# First terminal: start the api
$ rake start:api
```

```bash
# Second terminal: start the consumers
$ rake start:consumers
```

```bash
# Third terminal: start the streaming server
$ rake start:streaming
```

```bash
# Fourth terminal: start the web client
$ rake start:web
```

### Using the service

- The API can be reached at [http://localhost:3000](http://localhost:3000)
- The Streaming Server can be reached at [http://localhost:9292](http://localhost:9292)
  - It will accept WebSocket connections.
- The WEB client can be reached at [http://localhost:3001](http://localhost:3001)

There are a few ways you can test the service.

1. Running door2door's driver simulator. **
2. Running a performance test.
3. Manually.

** The method that does the requests has to be changed to include the path ```/api/v1``` as demonstrated below.

```bash
const req = http.request(
    { …
      path: `/api/v1${path}`,
      …
      }
   …
  );
```

#### Running door2door simulator
See: [Driver Simulator Instructions](https://github.com/door2door-io/d2d-code-challenges/tree/master/resources/driver-simulator)

#### Run API Performance Tests

The performance of the API can be verified using [Apache Bench](https://httpd.apache.org/docs/2.4/programs/ab.html) to simulate concurrency and load.

Run the command below to test the API with the following parameters:

|Parameter            |value  |
|---------------------|-------|
|# concurrent clients |100    |
|# requests           |20.000 |

```bash
$ rake perftest
```

Samples:
[Local test execution](docs/images/performance-tests-running-on-docker-local-machine.png) with all services running on Docker locally.


#### Final notes

Assumptions:

1) There's no validation if the vehicle is registered when the location update endpoint is called as it was defined that the vehicle will never contact this endpoint without having registered first.

