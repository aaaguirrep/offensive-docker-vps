// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  count       = var.vps_number
  byte_length = 8
}

resource "digitalocean_droplet" "vm_instance" {
  count       = var.vps_number
  image       = "ubuntu-18-04-x64"
  name        = "offensive-docker-vm-${random_id.instance_id[count.index].hex}"
  region      = var.region
  size        = "s-2vcpu-4gb"
  vpc_uuid    = digitalocean_vpc.vpc_network.id
  ssh_keys    = [digitalocean_ssh_key.ssh_public_key.fingerprint]
  user_data   = data.template_file.cloud_init_yaml.rendered
}

resource "digitalocean_ssh_key" "ssh_public_key" {
  name       = "ssh_public_key"
  public_key = file(var.ssh_public_key)
}

data "template_file" "cloud_init_yaml" {
  template = file("cloud-init.yaml")
  vars = {
    ssh_public_key = file(var.ssh_public_key)
    username = var.username
  }
}

data "template_file" "dev_hosts" {
  template = file("${path.module}/templates/host.cfg")
  depends_on = [
    digitalocean_droplet.vm_instance,
  ]
  vars= {
    externalIP = join("\n", digitalocean_droplet.vm_instance.*.ipv4_address)
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
