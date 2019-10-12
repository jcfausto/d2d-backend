import React from 'react';
import Row from 'react-bootstrap/Row';
import Form from 'react-bootstrap/Form';
import Col from 'react-bootstrap/Col';

const OperationParameters = (props) => {
    return (
      <Row className="operation-params">
        <h6>Operation Parameters</h6>
        <hr />
        <Form>
          <Form.Group controlId="centralPoint">
            <Form.Label>Central point (lat, lng):</Form.Label>
            <Form.Row>
              <Col>
                <Form.Control
                  type="text"
                  placeholder="Type a latitude..."
                  value={props.centralPoint[0]}
                  readOnly={true}
                />
              </Col>
              <Col>
                <Form.Control
                  type="text"
                  placeholder="Type a longitude..."
                  value={props.centralPoint[1]}
                  readOnly={true}
                />
              </Col>
            </Form.Row>
          </Form.Group>
          <Form.Group controlId="radius">
            <Form.Label>Radius: ({props.operationRadius} kilometeres) </Form.Label>
            <Form.Control
              type="range"
              placeholder="Radius in kilometers..."
              defaultValue={props.operationRadius}
              disabled={true} />
          </Form.Group>
          <Form.Group controlId="displayLimits">
            <Form.Check
              type="checkbox"
              label="Display limits on the map"
              onChange={props.onDisplayLimitsChange}
            />
          </Form.Group>
        </Form>
      </Row>
    );
}

export default OperationParameters;
