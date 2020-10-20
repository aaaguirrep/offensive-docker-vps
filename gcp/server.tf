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

data "template_file" "dev_hosts" {
  template = file("${path.module}/templates/host.cfg")
  depends_on = [
    google_compute_instance.vm_instance,
  ]
  vars= {
    externalIP = join("\n", google_compute_instance.vm_instance.*.network_interface.0.access_config.0.nat_ip)
  }
}

resource "null_resource" "sleep-before-ansible" {
  triggers = {
    template_rendered = data.template_file.dev_hosts.rendered
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }
}

resource "null_resource" "dev-hosts" {
  depends_on = [
    null_resource.sleep-before-ansible,
  ]
  provisioner "local-exec" {
    command = "echo '${data.template_file.dev_hosts.rendered}' > ../ansible/hosts.yaml"
  }
  provisioner "local-exec" {
    command = "cd ../ansible  && ansible-playbook playbook.yaml "
  }
}
