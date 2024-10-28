# Define the architecture as an argument with a default value for flexibility
ARG ARCH=arm64v8

# Use the slim Python image based on the specified architecture
FROM ${ARCH}/python:3.9-slim

# Update and install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 \
    libsqlite3-dev \
    git && \
    rm -rf /var/lib/apt/lists/*  # Clean up to reduce image size

# Upgrade pip and install essential Python packages
RUN pip3 install -U pip setuptools wheel && \
    pip3 install django-x509

# Set the working directory for cloning and installing django-x509
WORKDIR /app

# Clone the django-x509 repository, install requirements, and clean up
RUN git clone  https://github.com/openwisp/django-x509.git && \
    cd django-x509 && \
    pip3 install -r requirements.txt && \
    pip3 install -r requirements-test.txt 

# Confirm installation
RUN echo "django-x509 Installed"

# Set the working directory to /app/tests
WORKDIR /app/django-x509/tests

# Expose port 8000
EXPOSE 8000

# Set environment variables
ENV NAME=djangox509

# Define the entrypoint command
CMD ["./docker-entrypoint.sh"]