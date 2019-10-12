import React from 'react';
import ListGroup from 'react-bootstrap/ListGroup';
import Container from 'react-bootstrap/Container';
import Col from 'react-bootstrap/Col';
import Row from 'react-bootstrap/Row';
import Image from 'react-bootstrap/Image';
import carIcon from '../assets/carIcon.png';
import Moment from 'react-moment';


const Vehicle = (props) => {
  let styles = {
    transform: `rotateZ(${Math.trunc(props.vehicle.bearing)}deg)`,
    display: 'inline-block',
  }
  return (
    <ListGroup.Item key={props.vehicle.vehicle_id} >
      <Container fluid={true}>
        <Row>
          <Col sm={4}>
            <Image src={carIcon} style={styles} />
            <p><span>Heading: </span>{Math.trunc(props.vehicle.bearing)}°</p>
          </Col>
          <Col sm={8}>
            <p><span>ID: </span>{props.vehicle.vehicle_id.split("-")[0]}</p>
            <p><span>At: </span><Moment>{props.vehicle.at}</Moment></p>
          </Col>
        </Row>
      </Container>
    </ListGroup.Item>
  );
}

export default Vehicle;
