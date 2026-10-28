
# GCP DevOps Project: Terraform, Docker, FastAPI & CI/CD

A beginner-friendly DevOps project that deploys a containerized FastAPI application to Google Cloud Run using Terraform, Google Artifact Registry, and GitHub Actions.

## Project Overview

This project demonstrates Infrastructure as Code (IaC), containerization, cloud deployment, and automated CI/CD using Google Cloud Platform (GCP).

## Architecture

Developer → GitHub → GitHub Actions → Workload Identity Federation → Docker Build → Artifact Registry → Cloud Run

## Technologies Used

- **Google Cloud Platform:** Cloud Run, Artifact Registry, IAM
- **Terraform:** Infrastructure as Code
- **Docker:** Application containerization
- **Python & FastAPI:** REST API
- **Git & GitHub:** Version control
- **GitHub Actions:** CI/CD automation
- **Workload Identity Federation:** Keyless GitHub-to-GCP authentication

## Application Endpoints

| Endpoint | Purpose |
|---|---|
| `/` | Application status and welcome response |
| `/health` | Health check |
| `/docs` | Interactive API documentation |

## CI/CD Workflow

When code is pushed to the `main` branch, GitHub Actions:

1. Checks out the repository.
2. Authenticates to Google Cloud using Workload Identity Federation.
3. Configures Docker authentication for Artifact Registry.
4. Builds the Docker image.
5. Pushes the image to Google Artifact Registry.
6. Deploys the image to Google Cloud Run.

The workflow can also be started manually using `workflow_dispatch`.

## Infrastructure

Terraform configuration is maintained in `main.tf`.

The configuration defines:
- An Artifact Registry Docker repository.
- A Cloud Run service.
- Public invocation access for the demo API.

## Run Locally

From the project root:

```powershell
docker build -t gcp-fastapi-demo:1.0 ./app
docker run --rm -p 8081:8080 gcp-fastapi-demo:1.0
```

Open these URLs in a browser:

- http://localhost:8081/
- http://localhost:8081/health
- http://localhost:8081/docs

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml
├── app/
│   ├── Dockerfile
│   ├── main.py
│   └── requirements.txt
├── .gitignore
├── main.tf
└── README.md
```

## Security Notes

- GitHub Actions authenticates using Workload Identity Federation instead of a long-lived service-account JSON key.
- The identity provider is restricted to the intended GitHub repository.
- Never commit credentials, secrets, Terraform state files, or local environment files.

## Cost Awareness

Cloud Run, Artifact Registry, and other Google Cloud resources may incur charges depending on usage and configuration. Monitor billing and remove resources that are no longer needed.

## Future Improvements

- Add automated tests for the FastAPI endpoints.
- Add Docker image vulnerability scanning.
- Add Terraform validation and formatting checks to CI.
- Improve deployment monitoring and rollback procedures.

## Project Status

The initial deployment and GitHub Actions CI/CD workflow have been tested successfully.
