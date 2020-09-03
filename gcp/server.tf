// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  count        = var.vps_number
  byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "vm_instance" {
  count        = var.vps_number
  name         = "offensive-docker-vm-${random_id.instance_id[count.index].hex}"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-1804-lts"
     size = "30"
   }
 }

 network_interface {
   network = google_compute_network.vpc_network.self_link

   access_config {
     // Include this section to give the VM an external ip address
   }
 }

 metadata = {
     ssh-keys = "${var.username}:${file(var.ssh_public_key)}"
 }
}