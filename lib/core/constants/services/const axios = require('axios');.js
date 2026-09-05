const axios = require('axios');

app.post('/webhook/uipath', async (req, res) => {
  const payload = req.body;

  try {
    await axios.post(
      process.env.POWER_AUTOMATE_URL,
      {
        process: payload.process,
        status: payload.status,
        message: payload.message,
        machine: payload.machine,
        timestamp: new Date().toISOString(),
      },
      {
        headers: {
          'Content-Type': 'application/json',
        },
      }
    );

    return res.status(200).json({
      success: true,
      message: 'Webhook received and forwarded to Power Automate',
    });
  } catch (error) {
    return res.status(500).json({
      success: false,
      message: 'Failed to forward to Power Automate',
      error: error.message,
    });
  }
});