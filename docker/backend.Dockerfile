# Use Python base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy dependency file
COPY requirements.txt .

# Install project dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the source code files and requirements to the container
COPY . .

# Exposes the port on which the FastAPI server will run
EXPOSE 8080

# Defines the command to start the FastAPI server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]
