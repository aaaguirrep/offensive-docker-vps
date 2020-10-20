terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "1.23.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}