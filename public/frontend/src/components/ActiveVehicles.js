import React from 'react';
import Vehicle from './Vehicle';
import ListGroup from 'react-bootstrap/ListGroup';
import Row from 'react-bootstrap/Row';

const ActiveVehicles = (props) => {
  var items = [];

  props.vehicles.forEach((vehicle) => {
    items.push(<Vehicle key={vehicle.vehicle_id} vehicle={vehicle} />)
  });

  return (
    <Row>
      <label>
        <h6>Active Vehicles</h6>
      </label>
      {items.length > 0 &&
        <ListGroup>
          { items }
        </ListGroup>
      }
    </Row>
  );
}

export default ActiveVehicles;
