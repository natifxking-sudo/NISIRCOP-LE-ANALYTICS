-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create roles table
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

-- Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- In a real app, this would be a hash
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create a join table for the many-to-many relationship between users and roles
CREATE TABLE user_roles (
    user_id INTEGER NOT NULL,
    role_id INTEGER NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- Create police_stations table with a geometry column for boundaries
CREATE TABLE police_stations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    boundary GEOMETRY(Polygon, 4326) -- SRID 4326 for WGS 84
);

-- Add a foreign key from users to police_stations (for POLICE_STATION role)
ALTER TABLE users ADD COLUMN police_station_id INTEGER;
ALTER TABLE users ADD CONSTRAINT fk_police_station FOREIGN KEY (police_station_id) REFERENCES police_stations(id);


-- Create incidents table with a geometry column for location
CREATE TABLE incidents (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    priority VARCHAR(50),
    status VARCHAR(50),
    location GEOMETRY(Point, 4326), -- SRID 4326 for WGS 84
    reported_by_id INTEGER NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (reported_by_id) REFERENCES users(id)
);

-- Insert sample data

-- 1. Roles
INSERT INTO roles (name) VALUES ('OFFICER'), ('POLICE_STATION'), ('SUPER_USER');

-- 2. Police Stations with boundaries (simple rectangular polygons for example)
-- Downtown Station
INSERT INTO police_stations (name, boundary) VALUES (
    'Downtown Station',
    ST_GeomFromText('POLYGON((-74.0 40.7, -74.0 40.8, -73.9 40.8, -73.9 40.7, -74.0 40.7))', 4326)
);
-- Uptown Station
INSERT INTO police_stations (name, boundary) VALUES (
    'Uptown Station',
    ST_GeomFromText('POLYGON((-74.0 40.8, -74.0 40.9, -73.9 40.9, -73.9 40.8, -74.0 40.8))', 4326)
);


-- 3. Users (passwords are plaintext for demonstration; USE BCRYPT IN PRODUCTION)
-- Super User
INSERT INTO users (username, password, email, full_name) VALUES ('superuser', 'password123', 'super@example.com', 'Super User');
-- Downtown Station Admin
INSERT INTO users (username, password, email, full_name, police_station_id) VALUES ('downtown_admin', 'password123', 'downtown@example.com', 'Downtown Admin', 1);
-- Uptown Station Admin
INSERT INTO users (username, password, email, full_name, police_station_id) VALUES ('uptown_admin', 'password123', 'uptown@example.com', 'Uptown Admin', 2);
-- Officer 1 (Downtown)
INSERT INTO users (username, password, email, full_name, police_station_id) VALUES ('officer1', 'password123', 'officer1@example.com', 'Jane Doe', 1);
-- Officer 2 (Uptown)
INSERT INTO users (username, password, email, full_name, police_station_id) VALUES ('officer2', 'password123', 'officer2@example.com', 'John Smith', 2);

-- 4. Assign Roles to Users
-- superuser -> SUPER_USER
INSERT INTO user_roles (user_id, role_id) VALUES (1, 3);
-- downtown_admin -> POLICE_STATION
INSERT INTO user_roles (user_id, role_id) VALUES (2, 2);
-- uptown_admin -> POLICE_STATION
INSERT INTO user_roles (user_id, role_id) VALUES (3, 2);
-- officer1 -> OFFICER
INSERT INTO user_roles (user_id, role_id) VALUES (4, 1);
-- officer2 -> OFFICER
INSERT INTO user_roles (user_id, role_id) VALUES (5, 1);

-- 5. Incidents
-- Incident reported by Officer 1 in Downtown
INSERT INTO incidents (title, description, priority, status, location, reported_by_id) VALUES (
    'Theft at Central Park',
    'A bike was reported stolen near the south entrance.',
    'MEDIUM',
    'OPEN',
    ST_SetSRID(ST_MakePoint(-73.95, 40.75), 4326),
    4
);
-- Incident reported by Officer 2 in Uptown
INSERT INTO incidents (title, description, priority, status, location, reported_by_id) VALUES (
    'Vandalism on 125th Street',
    'Graffiti reported on a storefront.',
    'LOW',
    'OPEN',
    ST_SetSRID(ST_MakePoint(-73.95, 40.85), 4326),
    5
);
-- Incident reported by Officer 1 in Downtown
INSERT INTO incidents (title, description, priority, status, location, reported_by_id) VALUES (
    'Assault on Main Street',
    'A physical altercation was reported.',
    'HIGH',
    'CLOSED',
    ST_SetSRID(ST_MakePoint(-73.98, 40.72), 4326),
    4
);
