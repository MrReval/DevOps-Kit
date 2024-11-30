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

# Expose port for Vue.js app
EXPOSE 8080

# Start Vue.js app
CMD ["npm", "run", "serve"]
