output "external_ip" {
    description = "Public IP address"
    value = digitalocean_droplet.vm_instance.*.ipv4_address
}