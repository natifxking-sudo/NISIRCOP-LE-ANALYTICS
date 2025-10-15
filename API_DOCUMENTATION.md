# API Documentation: NISIRCOP-LE-ANALYTICS

This document provides a complete reference for the NISIRCOP-LE-ANALYTICS REST API.

## 1. Authentication

All API endpoints are secured and require a valid JSON Web Token (JWT) to be passed in the `Authorization` header.

```
Authorization: Bearer <your_jwt_token>
```

To obtain a token, send a `POST` request to the **Auth Service**.

### Auth Service (`/api/v1/auth`)
-   **`POST /login`**: Authenticates a user and returns a JWT.
    -   **Request Body:**
        ```json
        {
          "username": "your_username",
          "password": "your_password"
        }
        ```
    -   **Response:**
        ```json
        {
          "token": "ey..."
        }
        ```

---

## 2. API Endpoints by Service

The API is organized by microservice. All paths are prefixed by the API Gateway.

### 2.1. User Service (`/api/v1/users`)

| Method | Endpoint                    | Description                       | Required Role    |
|--------|-----------------------------|-----------------------------------|------------------|
| `GET`  | `/`                         | Get a list of all users.          | `SUPER_USER`     |
| `POST` | `/`                         | Create a new user.                | `SUPER_USER`, `POLICE_STATION` |
| `GET`  | `/{id}`                     | Get details for a specific user.  | Any              |
| `GET`  | `/username/{username}`      | Get user by username (internal).  | (Service-to-service) |
| `PUT`  | `/{id}`                     | Update a user's details.          | `SUPER_USER`, Owner |
| `DELETE`| `/{id}`                    | Delete a user.                    | `SUPER_USER`     |


### 2.2. Incident Service (`/api/v1/incidents`)

| Method | Endpoint | Description                | Required Role |
|--------|----------|----------------------------|---------------|
| `POST` | `/`      | Report a new incident.     | `OFFICER`     |
| `GET`  | `/`      | Get a list of incidents.   | Any           |
| `GET`  | `/{id}`  | Get details for an incident.| Any           |
| `PUT`  | `/{id}`  | Update an incident's status.| `POLICE_STATION`, `SUPER_USER` |

### 2.3. Geographic Service (`/api/v1/geo`)

| Method | Endpoint     | Description                                               | Required Role |
|--------|--------------|-----------------------------------------------------------|---------------|
| `POST` | `/validate`  | Validate if a geographic point is within a user's boundary.| `OFFICER`     |
| `GET`  | `/stations`  | Get a list of all police stations and their boundaries.   | `SUPER_USER`  |
| `POST` | `/stations`  | Create a new police station with a boundary.              | `SUPER_USER`  |


### 2.4. Analytics Service (`/api/v1/analytics`)

| Method | Endpoint        | Description                                  | Required Role |
|--------|-----------------|----------------------------------------------|---------------|
| `GET`  | `/trends`       | Get crime trend data over a time period.     | `POLICE_STATION`, `SUPER_USER` |
| `GET`  | `/heatmap`      | Get data to generate a crime heat map.       | `POLICE_STATION`, `SUPER_USER` |
| `GET`  | `/stats`        | Get summary statistics for incidents.        | `POLICE_STATION`, `SUPER_USER` |
