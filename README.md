<!-- markdownlint-disable MD033 MD041 -->
<h2>Offensive Docker VPS</h2>

Create a VPS on Google Cloud Platform or Digital Ocean easily to use [Offensive Docker](https://github.com/aaaguirrep/offensive-docker) and launch the assessments to the targets.

:tada::tada:**Digital Ocean Bonus**:tada::tada:
You can sign up with my referral link <https://m.do.co/c/0d2d40f6a8a1> and get $100 free credit to try it out!

#### Table of contents

- [Requirements](#requirements)
- [Usage](#usage)
  - [1.- Clone the repository](#1--clone-the-repository)
  - [2.- Credentials](#2--credentials)
    - [For Google Cloud Platform](#for-google-cloud-platform)
    - [For Digital Ocean](#for-digital-ocean)
    - [SSH Private and Public keys](#ssh-private-and-public-keys)
  - [3.- Full Automation: Terraform and Ansible](#3--full-automation-terraform-and-ansible)
    - [Google Cloud Platform](#google-cloud-platform)
    - [Digital Ocean](#digital-ocean)
  - [4.- Access to VPS](#4--access-to-vps)
  - [5.- Destroy the VPS](#5--destroy-the-vps)
- [:shield: Security](#shield-security)
- [:coffee: Donations](#coffee-donations)
- [Contributing](#contributing)
- [:chart_with_upwards_trend: Stargazers over time](#chart_with_upwards_trend-stargazers-over-time)
- [License](#license)

### Requirements

- Terraform installed (Version used: v0.13.4)
- Ansible installed (Version used: 2.9.12)
- SSH private and public keys
- Google Cloud Platform or Digital Ocean account.

### Usage

#### 1.- Clone the repository

```console
git clone --depth 1 https://github.com/aaaguirrep/offensive-docker-vps.git vps
cd vps
```

#### 2.- Credentials

- Create credentials folder.

    ```console
    mkdir credentials
    ```

##### For Google Cloud Platform

- Create a new project.
- Create service account with "Compute Admin" role and download a key in json format in credentials folder.
- Rename the key to gcp.json
- Enable "Compute Engine API" for the project.

##### For Digital Ocean

- Create a Personal access tokens with write permission and copy it. [See Tutorial](https://www.digitalocean.com/docs/apis-clis/api/create-personal-access-token/)

##### SSH Private and Public keys

- Inside credentials folder run `ssh-keygen -t rsa -f offensive` in the terminal. Empty passphrase is ok.
- It creates two files: private and public key.

#### 3.- Full Automation: Terraform and Ansible

##### Google Cloud Platform

- Enter to gcp folder and modify the next value:
  - In main.tf file change the project value with your project-id.
- Run the next commands:

```console
# Initialize terraform provider
$ terraform init
Terraform has been successfully initialized!

# Create the resources
$ terraform apply -auto-approve
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
Outputs:
external_ip = x.x.x.x
```

- Copy the external_ip value

**Note:** The instance type and the region used are: n1-standard-1 and us-central1. You can change the values on server.tf and main.tf

**Demo**
[![asciicast](https://asciinema.org/a/359398.png)](https://asciinema.org/a/359398)

##### Digital Ocean

- Enter to digital-ocean folder
- With the personal access token copied run `export TF_VAR_do_token="Personal_Access_Token_Here"`
- Run the next commands:

```console
# Initialize terraform provider
$ terraform init
Terraform has been successfully initialized!

# Create the resources
$ terraform apply -auto-approve
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.
Outputs:
external_ip = x.x.x.x
```

- Copy the external_ip value

**Note:** The droplet type and the region used are: s-2vcpu-4gb and nyc3. You can change the values on server.tf and variables.tf

**Demo**
[![asciicast](https://asciinema.org/a/359408.png)](https://asciinema.org/a/359408)

#### 4.- Access to VPS

- In gcp or digital-ocean folder run the next command. Change x.x.x.x by external_ip value copied.

```Console
# Access to VPS
$ ssh offensive@x.x.x.x -i ../credentials/offensive
```

**Demo**
[![asciicast](https://asciinema.org/a/352904.png)](https://asciinema.org/a/352904)

#### 5.- Destroy the VPS

- In gcp or digital-ocean folder run the next command.

```Console
# Destroy the resource
$ terraform destroy -auto-approve
```

:warning:**Note:** For Digital Ocean, if you dont have a default VPC created in the region used it shows an error to destroy the VPC but no problem, it will destroy the others resources.

### :shield: Security

The service fail2ban has been installed to avoid brute force and block non-authorized users. :ghost::ghost:

### :coffee: Donations

Thanks for your donations, are always appreciated.

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/aaaguirrep)

### Contributing

[Contributing Guide](CONTRIBUTING.md)

### :chart_with_upwards_trend: Stargazers over time

[![Stargazers over time](https://starchart.cc/aaaguirrep/offensive-docker-vps.svg)](https://starchart.cc/aaaguirrep/offensive-docker-vps)

### License

[MIT](LICENSE)

Copyright (c) 2020, Arsenio Aguirre
