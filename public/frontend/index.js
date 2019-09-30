const path = require('path');
const express = require('express');

const app = express();
const port = process.env.PORT || "9000";
app.use('/', express.static('.'))

app.listen(port, () => {
  console.log(`Listening to requests on http://localhost:${port}`);
});
