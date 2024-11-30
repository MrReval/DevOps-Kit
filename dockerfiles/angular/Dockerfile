# Use official Node.js image
FROM node:16

# Set working directory
WORKDIR /app

# Copy project files
COPY ./src /app/

# Install dependencies
RUN npm install

# Build the app
RUN npm run build --prod

# Expose port for Angular app
EXPOSE 80

# Start Angular app using Nginx
FROM nginx:alpine
COPY --from=0 /app/dist /usr/share/nginx/html

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
