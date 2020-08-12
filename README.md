<!-- markdownlint-disable MD033 MD041 -->
<h2>VPS - Docker for pentest</h2>

Create a VPS on Google Cloud Platform or Digital Ocean easily with the [docker for pentest](https://github.com/aaaguirrep/pentest) included to launch the assessment to the target.

**Digital Ocean Bonus**
You can sign up with my referral link <https://m.do.co/c/0d2d40f6a8a1> and get $100 free credit to try it out!

#### Table of contents

- [Requirements](#requirements)
- [Usage](#usage)
  - [1.- Clone the repository](#1--clone-the-repository)
  - [2.- Credentials](#2--credentials)
    - [For Google Cloud Platform](#for-google-cloud-platform)
    - [For Digital Ocean](#for-digital-ocean)
    - [SSH Private and Public keys](#ssh-private-and-public-keys)
  - [3.- Terraform](#3--terraform)
    - [Google Cloud Platform](#google-cloud-platform)
    - [Digital Ocean](#digital-ocean)
  - [4.- Ansible](#4--ansible)
  - [5.- Access to VPS](#5--access-to-vps)
  - [6.- Destroy the VPS](#6--destroy-the-vps)
- [:coffee: Donations](#coffee-donations)
- [Contributing](#contributing)
- [:chart_with_upwards_trend: Stargazers over time](#chart_with_upwards_trend-stargazers-over-time)
- [License](#license)

### Requirements

- Terraform installed
- Ansible installed
- SSH private and public keys
- Google Cloud Platform or Digital Ocean account.

### Usage

#### 1.- Clone the repository

```console
git clone --depth 1 https://github.com/aaaguirrep/vps-docker-for-pentest.git vps
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
- Rename the key to pentest.json
- Enable "Compute Engine API" for the project.

##### For Digital Ocean

- Create a Personal access tokens with write permission and copy it. [See Tutorial](https://www.digitalocean.com/docs/apis-clis/api/create-personal-access-token/)

##### SSH Private and Public keys

- Inside credentials folder run `ssh-keygen -t rsa -f pentest` in the terminal. Empty passphrase is ok.
- It creates two files: private and public key.

#### 3.- Terraform

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
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
Outputs:
external_ip = x.x.x.x
```

- Copy the external_ip value

**Demo**
[![asciicast](https://asciinema.org/a/352900.png)](https://asciinema.org/a/352900)

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
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
Outputs:
external_ip = x.x.x.x
```

- Copy the external_ip value

**Demo**
[![asciicast](https://asciinema.org/a/352901.png)](https://asciinema.org/a/352901)

#### 4.- Ansible

- Enter to ansible folder
- In hosts.yaml change the x.x.x.x by external_ip value copied.
- Run the next command:

```console
$ ansible-playbook playbook.yaml
TASK [Configuration finished] *******************************************************
ok: [x.x.x.x] => {
    "msg": "System configured correctly."
}
```

**Demo**
[![asciicast](https://asciinema.org/a/352903.png)](https://asciinema.org/a/352903)

#### 5.- Access to VPS

- In gcp or digital-ocean folder run the next command. Change x.x.x.x by external_ip value copied.

```Console
# Access to VPS
$ ssh pentest@x.x.x.x -i ../credentials/pentest
```

**Demo**
[![asciicast](https://asciinema.org/a/352904.png)](https://asciinema.org/a/352904)

#### 6.- Destroy the VPS

- In gcp or digital-ocean folder run the next command.

```Console
# Destroy the resource
$ terraform destroy -auto-approve
```

### :coffee: Donations

Thanks for your donations, are always appreciated.

<a href="https://www.buymeacoffee.com/aaaguirrep" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" style="height: 23px !important; width: 100px !important;" ></a>

### Contributing

[Contributing Guide](CONTRIBUTING.md)

### :chart_with_upwards_trend: Stargazers over time

[![Stargazers over time](https://starchart.cc/aaaguirrep/vps-docker-for-pentest.svg)](https://starchart.cc/aaaguirrep/vps-docker-for-pentest)

### License

[MIT](LICENSE)

Copyright (c) 2020, Arsenio Aguirre
