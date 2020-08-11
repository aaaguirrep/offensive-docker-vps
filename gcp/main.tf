// Configure the Google Cloud provider
provider "google" {
    credentials = file("../credentials/pentest.json")
    project     = "docker-pentest"
    region      = "us-central1"
}