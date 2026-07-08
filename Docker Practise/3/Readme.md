Requirements:

Use node:20-alpine
Set WORKDIR to /usr/src/app
Copy package.json and package-lock.json first.
Install dependencies using npm ci.
Copy the rest of the application except .env (assume a proper .dockerignore exists).

Set the environment variable:

NODE_ENV=production
Expose port 5000.

Start the app using:

npm start