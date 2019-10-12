import React from 'react';

import 'bootstrap/dist/css/bootstrap.min.css';
import './App.css';

import Container from "react-bootstrap/Container";
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';

import Header from './components/Header';
import Sidebar from './components/Sidebar';
import MapView from './components/MapView';

import { w3cwebsocket as W3CWebSocket } from "websocket";

const streamingApiUrl = process.env.REACT_APP_STREAMING_API_URL;
const vehiclesApiOperationParamsUrl = process.env.REACT_APP_LOCATION_API_URL;
const client = new W3CWebSocket(streamingApiUrl);


class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      centralPoint: [0, 0],
      operationRadius: 1,
      displayLimitsOnMap: false,
      vehicles: new Map()
    }
  }

  onDisplayLimitsChange(event) {
    this.setState({
      displayLimitsOnMap: event.target.checked
    });
  }

  componentWillMount() {

    fetch(vehiclesApiOperationParamsUrl)
      .then(response => response.json())
      .then(data => this.setState({
        operationRadius: data.limitRadiusInKm,
        centralPoint: [data.centralPoint.lat, data.centralPoint.lng]})
      );

    client.onopen = () => {
      console.log('Connection established.');
    };

    client.onmessage = (message) => {
      const vehicleUpdate = JSON.parse(message.data);
      const newState = this.state.vehicles;
      newState.set(vehicleUpdate.vehicle_id, vehicleUpdate);
      this.setState({vehicles: newState});
    };
  }

  render() {
    return (
      <div className="content">
        <Header />
        <Container fluid="true" className="h-100">
          <Row className="justify-content-center h-100">
            <Col sm={3}>
              <Sidebar
                vehicles={this.state.vehicles}
                centralPoint={this.state.centralPoint}
                operationRadius={this.state.operationRadius}
                onDisplayLimitsChange={this.onDisplayLimitsChange.bind(this)}
              />
            </Col>
            <Col sm={9} style={{ paddingLeft: 0, paddingRight: 0 }}>
              <MapView
                className="map-view"
                vehicles={this.state.vehicles}
                centralPoint={this.state.centralPoint}
                operationRadius={this.state.operationRadius}
                displayLimitsOnMap={this.state.displayLimitsOnMap}
              />
            </Col>
          </Row>
        </Container>
      </div>
    )
  }
}

export default App;
