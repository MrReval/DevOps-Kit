# Use official Nginx image
FROM nginx:alpine

# Copy static files
COPY ./src /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
