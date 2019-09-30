var vehicles = new Map()
var mymap = L.map('mapid').setView([52.53, 13.403], 13)
var webSocket = new WebSocket('ws://127.0.0.1:9292/')

const schema = {
  "type": "object",
  "required": ["lat", "lng", "at", "vehicle_id"],
  "properties": {
    "lat": { "type":"number" },
    "lng": { "type":"number" },
    "bearing": { "type":"number" },
    "at": { "type":"string" },
    "vehicle_id": { "type":"string" }
  }
};

webSocket.onmessage = function (event) {
  console.log(event.data)

  var location = JSON.parse(event.data)
  console.log(jsonSchema.validate(location, schema))

  vehicle_id = location["vehicle_id"]
  let lat = location["lat"]
  let lng = location["lng"]
  let bearing = location["bearing"]
  var vehicle = vehicles.get(vehicle_id)

  if (vehicle) {
    newLatLng = new L.LatLng(lat, lng)
    vehicle.setLatLng(newLatLng).update()
    console.log(`vehicle updated: ${vehicle_id}`)
  } else {
    var marker = L.marker([lat, lng]).bindPopup(`<strong>${vehicle_id}</strong>`).addTo(mymap);
    vehicles.set(vehicle_id, marker)
    console.log(`vehicle created: ${vehicle_id}`)
  }
}

webSocket.onclose = function (event) {

  vehicles.forEach((marker, vehicle_id) => {
    mymap.removeLayer(marker);
    console.log(`removing vehicle ${vehicle_id}`)
  })
}

L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
  maxZoom: 18,
  attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
    '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
    'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
  id: 'mapbox.streets'
}).addTo(mymap);

L.circle([52.53, 13.403], 3500, {
  color: 'red',
  fillColor: '#f03',
  fillOpacity: 0.1
}).addTo(mymap);