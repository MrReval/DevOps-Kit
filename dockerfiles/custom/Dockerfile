# Use Ubuntu base image
FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && apt-get install -y curl git vim

# Set working directory
WORKDIR /app

# Copy project files
COPY ./src /app/

# Expose port 80
EXPOSE 80

# Custom startup command (to be defined by user)
CMD ["./start.sh"]
