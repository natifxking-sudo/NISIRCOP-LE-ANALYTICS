# NISIRCOP-LE-ANALYTICS Platform: A Technical Overview

## 1. Introduction

### 1.1. What is NISIRCOP-LE-ANALYTICS?
NISIRCOP-LE-ANALYTICS is a production-ready, microservices-based crime analytics platform designed to transition law enforcement agencies from paper-based workflows to a real-time, data-driven operational model. It provides tools for incident reporting, user management, and sophisticated crime data analysis.

### 1.2. The Vision
The platform's goal is to be a scalable, secure, and intuitive system that empowers law enforcement with actionable insights, helping to identify crime patterns, optimize resource allocation, and improve public safety.

### 1.3. Core Concepts
- **Microservices:** The backend is architected as a suite of small, independent services. This modular approach enhances scalability, resilience, and maintainability.
- **Microfrontends:** The frontend architecture mirrors the backend, with distinct modules for different business capabilities. This allows for independent development and deployment cycles.
- **Geospatial Intelligence:** The system leverages PostGIS to treat geographic data as a first-class citizen, enabling location-based incident reporting, boundary enforcement, and spatial analysis.
- **Role-Based Access Control (RBAC):** System access is strictly governed by user roles (OFFICER, POLICE_STATION, SUPER_USER), ensuring data security and integrity.

## 2. Technology Stack

| Component      | Technology                                    |
|----------------|-----------------------------------------------|
| **Backend**    | Java 17, Spring Boot 3, Spring Cloud          |
| **Frontend**   | Vue 3, Vite, Pinia, Tailwind CSS              |
| **Database**   | PostgreSQL 15, PostGIS 3.3                    |
| **Infrastructure** | Docker, Docker Compose                      |
| **Security**   | JWT Tokens, Spring Security                   |
| **Service Mesh** | Spring Cloud Gateway (Routing), Eureka (Discovery) |

## 3. Architecture Deep Dive

### 3.1. Backend Microservices
- **Eureka Server (`eureka-server`):** Acts as the service registry, allowing all other microservices to discover and communicate with each other dynamically.
- **API Gateway (`api-gateway`):** The single, unified entry point for all frontend requests. It handles routing to the appropriate downstream service, and is the place for cross-cutting concerns like security and rate limiting.
- **Auth Service (`auth-service`):** Manages user authentication, validates credentials, and generates JWTs.
- **User Service (`user-service`):** Manages all user-related data, including profiles, roles, and permissions, enforcing the RBAC model.
- **Geographic Service (`geographic-service`):** Performs all PostGIS-powered spatial operations, such as validating that an incident's coordinates fall within a specific police station's boundary.
- **Incident Service (`incident-service`):** Handles the full lifecycle of crime incident data, from creation and validation to retrieval and updates.
- **Analytics Service (`analytics-service`):** Aggregates and analyzes crime data to provide insights for dashboards, heatmaps, and trend reports.

### 3.2. Frontend Microfrontends
- **Shell (`frontend/shell`):** The main container application. It provides the primary layout, navigation, and is responsible for loading the other functional modules.
- **Incidents Module (`frontend/modules/incidents`):** The UI for reporting new incidents and viewing/managing existing ones.
- **Users Module (`frontend/modules/users`):** The interface for user administration, accessible based on role permissions.
- **Analytics Module (`frontend/modules/analytics`):** The data visualization hub, featuring dashboards, charts, and maps to display crime trends.

## 4. Codebase Structure

```
.
├── backend/
│   ├── Dockerfile.*           # Dockerfiles for each microservice
│   ├── api-gateway/
│   ├── analytics-service/
│   ├── auth-service/
│   ├── eureka-server/
│   ├── geographic-service/
│   ├── incident-service/
│   └── user-service/
├── database/
│   └── init.sql               # Database schema and initial data
├── docs/
│   └── ...                    # Original documentation files
├── frontend/
│   ├── Dockerfile.shell       # Dockerfile for the frontend
│   ├── shell/                 # The main Vue application shell
│   └── modules/               # Directory for microfrontend modules
├── .env                       # Environment variable configuration
├── docker-compose.yml         # Main orchestration file
└── learn-the-system.md        # This file
```

## 5. Getting Started

1.  **Prerequisites:** Ensure Docker and Docker Compose are installed on your system.
2.  **Environment File:** Create a `.env` file in the project root by copying the provided template. Fill in the required `POSTGRES_PASSWORD` and `JWT_SECRET`.
3.  **Launch:** Run the entire platform with a single command:
    ```bash
    docker-compose up --build -d
    ```
4.  **Access:**
    -   **Frontend:** `http://localhost:3000`
    -   **API Gateway:** `http://localhost:8080`
    -   **Eureka Dashboard:** `http://localhost:8761`
