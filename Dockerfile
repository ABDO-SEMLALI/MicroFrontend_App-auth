# Stage 1: Build environment
FROM node:17.0.0-alpine

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

# Update dependencies
RUN npm update

# Run the build process
RUN npm run build

EXPOSE 8082

# Command to start your application
CMD ["npm", "start", "--", "--host", "0.0.0.0", "--port", "8082"]
