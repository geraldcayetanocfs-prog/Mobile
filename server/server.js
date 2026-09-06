const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const admin = require('firebase-admin');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(bodyParser.json());

let firebaseReady = false;
const deviceTokens = new Set();

try {
  if (process.env.FIREBASE_SERVICE_ACCOUNT) {
    admin.initializeApp({
      credential: admin.credential.cert(
        JSON.parse(process.env.FIREBASE_SERVICE_ACCOUNT),
      ),
    });
    firebaseReady = true;
    console.log('Firebase Admin messaging is enabled');
  } else {
    console.warn('FIREBASE_SERVICE_ACCOUNT is not configured');
  }
} catch (error) {
  console.error('Firebase Admin initialization failed:', error.message);
}

const notifications = [];

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

app.post('/api/devices/register', (req, res) => {
  const token = req.body?.token;

  if (typeof token !== 'string' || token.trim().length < 20) {
    return res.status(400).json({
      success: false,
      message: 'A valid FCM token is required',
    });
  }

  deviceTokens.add(token.trim());
  return res.status(201).json({
    success: true,
    devices: deviceTokens.size,
  });
});

app.post('/webhook/uipath', async (req, res) => {
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

  let push = {sent: false, reason: 'Firebase Admin is not configured'};

  if (firebaseReady && deviceTokens.size > 0) {
    try {
      const response = await admin.messaging().sendEachForMulticast({
        tokens: [...deviceTokens],
        notification: {
          title: `${notification.process} ${notification.status}`,
          body: notification.message,
        },
        data: {
          process: notification.process,
          status: notification.status,
          message: notification.message,
          machine: notification.machine,
        },
      });
      push = {sent: response.successCount > 0, successCount: response.successCount};
    } catch (error) {
      push = {sent: false, reason: error.message};
    }
  }

  return res.status(200).json({
    success: true,
    message: 'Webhook received',
    data: notification,
    push,
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
