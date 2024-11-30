# Use official Python image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy project files
COPY ./src /app/

# Install dependencies
RUN pip install -r requirements.txt

# Expose port for Django
EXPOSE 8000

# Set environment variables for Django
ENV PYTHONUNBUFFERED 1

# Start Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
