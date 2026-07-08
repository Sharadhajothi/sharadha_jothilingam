FROM node:20-alpine
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
ENV NODE_ENV=production
EXPOSE 5000
CMD ["npm", "start"]