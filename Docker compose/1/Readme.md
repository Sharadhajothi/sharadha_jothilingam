Requirements

Use:

Image: node:20-alpine

Container name:

node-app

Expose:

Host: 3000
Container: 3000

Current project directory should be mounted to:

/usr/src/app

Working directory:

/usr/src/app

Run:

npm install && npm start

Restart policy:

unless-stopped