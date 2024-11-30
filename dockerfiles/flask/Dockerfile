# Use official Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy project files
COPY ./src /app/

# Install dependencies
RUN pip install -r requirements.txt

# Expose port for Flask app
EXPOSE 5000

# Start Flask application
CMD ["python", "app.py"]
