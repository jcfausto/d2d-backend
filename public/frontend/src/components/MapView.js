import React from 'react';
import { Map, Marker, Circle, Popup, TileLayer } from 'react-leaflet';
import Moment from 'react-moment';

// Apparently leaflet has an bug and the workarround to make it work
// is described here: https://github.com/PaulLeCam/react-leaflet/issues/453
// Without that, the markers won't show on the map.
import 'leaflet/dist/leaflet.css';
import L from 'leaflet';

delete L.Icon.Default.prototype._getIconUrl;

L.Icon.Default.mergeOptions({
    iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
    iconUrl: require('leaflet/dist/images/marker-icon.png'),
    shadowUrl: require('leaflet/dist/images/marker-shadow.png')
});

const MapView = (props) => {
  const operationArea = (
    <Circle
      center={props.centralPoint}
      radius={props.operationRadius*1000}
      color={'red'}
      fillColor={'#f03'}
      fillOpacity={0.1}
    />
  );

  let officeIcon = L.divIcon({
    className: 'rotated-markerdiv',
    iconSize: [63,42],
    iconAnchor: null,
    popupAnchor: [0, -11]
  });
  officeIcon.options.html = `<div><img src="hqIcon.png" /></div>`;

  const centralPointMarker = (
    <Marker key={'centralPoint'} position={props.centralPoint} icon={officeIcon} >
      <Popup>
        <span><strong>Central Point</strong><br />Lat: {props.centralPoint[0]} <br /> Lng: {props.centralPoint[1]}</span>
      </Popup>
    </Marker>
  );

  var markers = [];
  markers.push(centralPointMarker);

  props.vehicles.forEach((vehicle) => {
    const vehicleIcon = L.divIcon({
      className: 'rotated-markerdiv',
      iconSize: [63,42],
      iconAnchor: null,
      popupAnchor: [0, -11]
    });

    vehicleIcon.options.html = `<div><img src="carIcon.png" style="transform: rotateZ(${Math.trunc(vehicle.bearing)}deg);" /></div>`;

    markers.push(
      <Marker key={vehicle.vehicle_id} position={[vehicle.lat, vehicle.lng]} icon={vehicleIcon} >
        <Popup>
          <span>
            {vehicle.vehicle_id} <br />
            [{vehicle.lat},{vehicle.lng}] <br />
            {Math.trunc(vehicle.bearing)}° <br />
            <Moment>{vehicle.at}</Moment>
          </span>
        </Popup>
      </Marker>
    );
  });

  return (
    <Map center={props.centralPoint} zoom={13}>
      <TileLayer
          url="https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw"
          id="mapbox.streets"
        />
        { props.displayLimitsOnMap && operationArea }
        { markers }
    </Map>
  );
}

export default MapView;
