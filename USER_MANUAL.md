# User Manual: NISIRCOP-LE-ANALYTICS

Welcome to the NISIRCOP-LE-ANALYTICS platform. This manual provides a guide to using the system based on your assigned role.

## 1. Getting Started

### 1.1. Logging In
- **URL:** `http://localhost:3000`
- To access the system, open the URL in your web browser. You will be presented with a login screen.
- Use the credentials provided by your administrator. For a newly deployed system with the included sample data, you can use the following:

| Role             | Username         | Password      |
|------------------|------------------|---------------|
| Super User       | `superuser`      | `password123` |
| Police Station   | `downtown_admin` | `password123` |
| Officer          | `officer1`       | `password123` |

## 2. Role: OFFICER

As an OFFICER, your primary role is to report and manage crime incidents in the field.

### 2.1. Dashboard
Upon logging in, you will see your main dashboard, which provides an overview of incidents you have reported.

### 2.2. Reporting a New Incident
1.  Navigate to the **Incidents** section from the main menu.
2.  Click the **"Report New Incident"** button.
3.  A form will appear. Fill in the required fields:
    -   **Title:** A brief, clear summary of the incident.
    -   **Description:** A detailed account of the event.
    -   **Priority:** (e.g., LOW, MEDIUM, HIGH).
    -   **Location:** Click on the map to drop a pin at the exact location of the incident. The system will automatically validate if the location is within your operational boundary.
4.  Click **"Submit"** to save the incident. It will now be visible to your station's administrators.

### 2.3. Viewing Your Incidents
-   From the **Incidents** section, you can view a list of all incidents you have personally reported.
-   You can use the search and filter functions to find specific reports.

## 3. Role: POLICE_STATION

As a POLICE_STATION user, you are responsible for managing the officers and incidents within your station's designated geographical area.

### 3.1. Station Dashboard
Your dashboard provides a comprehensive view of all incidents reported within your jurisdiction. You can also see key analytics and trends specific to your area.

### 3.2. User Management
1.  Navigate to the **Users** module.
2.  Here, you can view a list of all `OFFICER` accounts assigned to your station.
3.  Click **"Create New Officer"** to add a new user. You will need to provide their full name, a unique username, and a temporary password.

### 3.3. Incident Monitoring
-   The **Incidents** module allows you to see all incidents reported by all officers in your station.
-   You can review incident details, update their status (e.g., from "OPEN" to "UNDER_INVESTIGATION"), and re-assign them if necessary.

## 4. Role: SUPER_USER

As a SUPER_USER, you have complete administrative access to the entire system.

### 4.1. System-Wide Analytics
-   The **Analytics** dashboard provides a global view of crime statistics and trends across all jurisdictions.
-   Use these powerful visualizations for strategic planning, resource allocation, and generating high-level reports.

### 4.2. Full User Management
1.  Navigate to the **Users** module.
2.  You have the ability to create, view, modify, and delete any user account in the system.
3.  This includes the ability to create new `POLICE_STATION` users and assign them to their respective geographic boundaries.

### 4.3. System Configuration
-   The SUPER_USER role is also responsible for managing system-level configurations, such as defining the geographic boundaries for each police station.
