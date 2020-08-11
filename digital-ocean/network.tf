resource "digitalocean_vpc" "vpc_network" {
  name     = "vpc-network"
  region   = var.region
}
