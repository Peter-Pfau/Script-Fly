# Script-Fast
Script Builder for PowerShell Active Directory

## Server Setup

This project includes a simple Express server to serve the Script-Fast web application.

### Prerequisites

- Node.js (Download and install from [nodejs.org](https://nodejs.org/))

### Installation

1. Clone or download this repository
2. Navigate to the project directory
3. Install dependencies:
   ```
   npm install
   ```

### Running the Server

To start the server, run:
```
npm start
```
or
```
node server.js
```

The server will start at http://localhost:3000. Open this URL in your web browser to access the Script-Fast application.

### Features

- Serves the Script-Fast web application
- Handles static files (CSS, JavaScript, images)
- Configurable port (default: 3000)

### Configuration

You can change the port by setting the PORT environment variable:
```
PORT=8080 node server.js
```

### Stopping the Server

Press `Ctrl+C` in the terminal to stop the server.
