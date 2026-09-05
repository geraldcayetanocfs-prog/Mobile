const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json());

const notifications = [
  {
    process: 'EBS',
    status: 'Failed',
    message: 'SAP Login Failed',
    machine: 'UAT01',
    timestamp: new Date().toISOString(),
  },
  {
    process: 'AR Clearing',
    status: 'Success',
    message: 'Completed',
    machine: 'PRD01',
    timestamp: new Date().toISOString(),
  },
];

app.get('/api/uipath/status', (req, res) => {
  res.json({
    process: 'UiPath Monitor',
    status: 'online',
    machine: 'SERVER-01',
    timestamp: new Date().toISOString(),
  });
});

app.get('/api/uipath/notifications', (req, res) => {
  res.json(notifications);
});

app.post('/webhook/uipath', (req, res) => {
  const payload = req.body;

  if (!payload || !payload.process) {
    return res.status(400).json({
      success: false,
      message: 'Invalid payload',
    });
  }

  const notification = {
    process: payload.process,
    status: payload.status || 'Success',
    message: payload.message || 'Bot completed',
    machine: payload.machine || 'UNKNOWN',
    timestamp: new Date().toISOString(),
  };

  notifications.unshift(notification);

  return res.status(200).json({
    success: true,
    message: 'Webhook received',
    data: notification,
  });
});

app.get('/', (req, res) => {
  res.json({
    message: 'UiPath Monitor Webhook Server is running',
  });
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
