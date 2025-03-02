## Flask Tournament Management Image Overview This Docker image provides a complete environment for running a Flask tournament management application with Gunicorn for production deployment and SSH for remote access. The image is specifically configured for a tournament management system that handles participants, matches, and scoring. Features

Python 3.10 with Flask framework Gunicorn production WSGI server SSH server for remote access and management Supervisor for process management PostgreSQL support with psycopg2

# Image Contents

Base: python:3.10-slim Exposed ports:

8000: Gunicorn web server 22: SSH server

Default user: root (password: password)

Usage Basic Run bashCopydocker run -d -p 8000:8000 -p 2201:22 --name flask_torneig your-username/flask-torneig:latest With Docker Compose This image works best as part of a multi-container setup with PostgreSQL: yamlCopyversion: '3'

services: flask: image: your-username/flask-torneig:latest container_name: flask_service volumes: - document_root:/app/web networks: - dev ports: - "8000:8000" - "2201:22" depends_on: - postgres restart: unless-stopped

postgres: image: postgres:15 container_name: postgres_service environment: POSTGRES_USER: pguser POSTGRES_PASSWORD: pgpassword POSTGRES_DB: torneig volumes: - dbdata:/var/lib/postgresql/data networks: - dev ports: - "5432:5432" restart: unless-stopped

volumes: dbdata: document_root:

networks: dev: Application Structure The image expects the Flask application to be structured as follows: Copyweb/ ├── app.py # Main application entry point ├── gestio_participants.py # Participant management module ├── gestio_partides.py # Match management module ├── puntuacions.py # Scoring module ├── utils.py # Utility functions ├── participants.json # Participant data ├── puntuacions.json # Scoring data └── templates/ ├── index.html # Main page template ├── participants.html # Participants page template ├── partides.html # Matches page template ├── puntuacions.html # Scores page template └── ranking.html # Ranking page template Environment Variables No specific environment variables are required, but the application may need to be configured to connect to PostgreSQL using the following connection details when used with the docker-compose setup:

Host: postgres Database: torneig User: pguser Password: pgpassword

## Volumes

/app/web: Mount your Flask application code here

## SSH Access The container runs an SSH server for remote access: bashCopyssh root@localhost -p 2201

Password: password
