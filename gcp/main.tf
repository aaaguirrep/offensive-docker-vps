// Configure the Google Cloud provider
provider "google" {
    credentials = file("../credentials/pentest.json")
    project     = "project-id"
    region      = "us-central1"
}