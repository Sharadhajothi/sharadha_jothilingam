Requirements
Build the image
Use node:20-alpine
Set WORKDIR to /usr/src/app
Copy only the package files first.
Install dependencies using npm ci.
Copy the remaining application files.
Runtime Configuration

The application listens on the port specified by the environment variable PORT.

Define a build-time argument named APP_PORT.
Set an environment variable PORT using the value of APP_PORT.
If no build argument is passed, the default port should be 5000.

Example:

docker build --build-arg APP_PORT=8080 .

After the image is built, inside the container:

PORT=8080

If no build argument is provided:

PORT=5000
Startup

Use:

npm start

But this time, use ENTRYPOINT instead of CMD.