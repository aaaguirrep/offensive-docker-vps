terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.35.0"
    }
  }
}

// Configure the Google Cloud provider
provider "google" {
    credentials = file("../credentials/pentest.json")
    project     = "project-id"
    region      = "us-central1"
}