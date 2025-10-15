# Deployment Guide: NISIRCOP-LE-ANALYTICS

This guide provides step-by-step instructions for deploying the NISIRCOP-LE-ANALYTICS platform using the provided Docker Compose setup.

## 1. Prerequisites

- **Docker:** Ensure the latest version of Docker is installed and running on your system. You can download it from the [official Docker website](https://www.docker.com/products/docker-desktop).
- **Docker Compose:** Docker Compose is included with modern Docker Desktop installations.
- **Git:** Required to clone the repository.

## 2. Initial Setup

### Step 2.1: Clone the Repository
First, clone the project repository to your local machine:
```bash
git clone <repository_url>
cd nisircop-le-analytics
```

### Step 2.2: Configure Environment Variables
The system requires a `.env` file in the project root for sensitive configuration data. Create this file:
```bash
touch .env
```
Now, open the `.env` file and add the following variables.

```env
# .env

# PostgreSQL Database Password
# Choose a strong, secure password for the database user.
POSTGRES_PASSWORD=your_strong_database_password

# JWT Secret Key
# This must be a long, random, and secret string for signing authentication tokens.
# A minimum of 256 bits (32 characters) is recommended.
JWT_SECRET=your_super_secret_jwt_key_that_is_at_least_256_bits_long
```
**Important:** Replace the placeholder values with your own secure credentials.

## 3. Running the Application

### Step 3.1: Build and Start
With Docker running and the `.env` file configured, launch the entire application stack using a single command from the project root:

```bash
docker-compose up --build -d
```

- `--build`: This flag forces Docker to build the images from the Dockerfiles the first time you run the command.
- `-d`: This flag runs the containers in detached mode, meaning they will run in the background.

The initial build process may take several minutes as it downloads base images and builds each microservice.

### Step 3.2: Verify the Services
Once the command completes, you can check that all containers are running:
```bash
docker-compose ps
```
You should see all the services (postgres, eureka-server, api-gateway, etc.) with a `running` status.

## 4. Accessing the Platform

The services are now accessible at the following local URLs:

| Service                 | URL                           | Credentials (Sample Data)             |
|-------------------------|-------------------------------|---------------------------------------|
| **Frontend Application**| `http://localhost:3000`       | `superuser` / `password123`           |
| **API Gateway**         | `http://localhost:8080`       | (Requires JWT Bearer Token)           |
| **Eureka Discovery Server**| `http://localhost:8761`       | (Service registry dashboard)          |

## 5. Managing the Application

### Stopping the Application
To stop all running containers without deleting any data, use:
```bash
docker-compose down
```

### Stopping and Deleting Data
To stop the containers **and remove the database volume** (which will permanently delete all data), use:
```bash
docker-compose down -v
```
This is useful for starting with a fresh, clean instance of the database.
