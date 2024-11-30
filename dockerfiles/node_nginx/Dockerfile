# Use official Node.js image
FROM node:16

# Set working directory
WORKDIR /app

# Copy project files
COPY ./src /app/

# Install dependencies
RUN npm install

# Build the app
RUN npm run build

# Expose port for Node.js
EXPOSE 3000

# Use official Nginx image
FROM nginx:alpine

# Copy Nginx config
COPY ./nginx/default.conf /etc/nginx/conf.d/

# Expose port for Nginx
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
