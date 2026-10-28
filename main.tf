
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = "terraform-docker-gcp"
  region  = "asia-south1"
  zone    = "asia-south1-a"
}

resource "google_artifact_registry_repository" "docker_repo" {
  location      = "asia-south1"
  repository_id = "gcp-fastapi-repo"
  description   = "Docker images for my GCP DevOps project"
  format        = "DOCKER"
}

resource "google_cloud_run_v2_service" "fastapi" {
  name     = "gcp-fastapi-demo"
  location = "asia-south1"

  deletion_protection = false

  template {
    scaling {
      min_instance_count = 0
      max_instance_count = 1
    }

    containers {
      image = "asia-south1-docker.pkg.dev/terraform-docker-gcp/gcp-fastapi-repo/gcp-fastapi-demo:1.0"

      ports {
        container_port = 8080
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

resource "google_cloud_run_v2_service_iam_member" "public_access" {
  project  = "terraform-docker-gcp"
  location = google_cloud_run_v2_service.fastapi.location
  name     = google_cloud_run_v2_service.fastapi.name

  role   = "roles/run.invoker"
  member = "allUsers"
}
