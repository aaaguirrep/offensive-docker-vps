terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.43.0"
    }
  }
}

// Configure the Google Cloud provider
provider "google" {
    credentials = file("../credentials/gcp.json")
    project     = "project-id"
    region      = "us-central1"
}