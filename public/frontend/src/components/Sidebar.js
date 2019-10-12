import React from 'react';
import Container from "react-bootstrap/Container";
import ActiveVehicles from './ActiveVehicles';
import OperationParameters from './OperationParameters';

const Sidebar = (props) => {
  return (
    <div className="sidebar">
      <Container>
        <OperationParameters
          centralPoint={props.centralPoint}
          operationRadius={props.operationRadius}
          onDisplayLimitsChange={props.onDisplayLimitsChange}
        />
        <ActiveVehicles vehicles={props.vehicles} />
      </Container>
    </div>
  )
}

export default Sidebar;
