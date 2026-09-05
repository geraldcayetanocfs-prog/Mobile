# mobile_monitoring

This project includes a Flutter mobile app and a small Node.js webhook backend for UiPath bot monitoring.

## Flutter app

- Connects to backend APIs via `ApiService`
- Uses `NotificationProvider` for app-level notification state
- Reads the base URL from `API_BASE_URL` or defaults to `http://localhost:3000`

## Node.js server

The backend is located in the `server` folder.

### Start the server

```bash
cd server
npm install
npm start
```

### API endpoints

- `GET /` → health check
- `GET /api/uipath/status` → bot status
- `GET /api/uipath/notifications` → notifications list
- `POST /webhook/uipath` → webhook receiver for bot events

### Example webhook payload

```json
{
  "process": "EBS",
  "status": "Failed",
  "message": "SAP Login Failed",
  "machine": "UAT01"
}
```

## Flutter environment variable example

```bash
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

If you are using a hosted backend instead, replace the URL with your deployed server address.
