// index.js
const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

app.get('/', (_, res) => res.send('Hello,This is an Optimized MS Dockerized Container running!'));
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
