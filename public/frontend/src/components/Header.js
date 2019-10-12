import React from 'react';

import Navbar from "react-bootstrap/Navbar";

const Header = () => {
  return (
      <div className="header">
        <Navbar bg="dark" variant="dark">
          <Navbar.Brand href="#home">Dashboard</Navbar.Brand>
        </Navbar>
      </div>
  );
}

export default Header;
