# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1

# Install pip and poetry or pipenv if needed for dependency management, then install FastAPI and Gunicorn
RUN pip install --upgrade pip && \
    pip install fastapi uvicorn gunicorn

# Copy the current directory contents into the container at /app
WORKDIR /app
COPY . /app

# Expose the port that the app will run on
EXPOSE 8000

# Run the application using Gunicorn with Uvicorn workers
CMD ["gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "main:app", "--bind", "0.0.0.0:8000"]
