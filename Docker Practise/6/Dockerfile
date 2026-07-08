FROM node:20-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
ARG APP_PORT=5000  /* This value is default if any value passed at build time it will be changed */
ENV PORT=$APP_PORT
EXPOSE 5000
ENTRYPOINT ["npm", "start"]

/* ARG available during image build time, ENV is inside running container */