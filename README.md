<!-- markdownlint-disable MD033 MD041 -->
<h2>VPS - Docker for pentest</h2>

#### Table of contents

- [Requirements](#requirements)
- [Usage](#usage)
  - [1.- Clone the repository](#1--clone-the-repository)
  - [2.- Credentials](#2--credentials)
    - [Google Cloud Platform](#google-cloud-platform)
    - [Digital Ocean](#digital-ocean)
    - [SSH Private and Public keys](#ssh-private-and-public-keys)
  - [3.- Terraform](#3--terraform)
  - [4.- Ansible](#4--ansible)

### Requirements

- Terraform installed
- Ansible installed
- SSH private and public keys
- Google Cloud Platform or Digital Ocean account

### Usage

#### 1.- Clone the repository

```console
git clone --depth 1 https://github.com/aaaguirrep/vps-docker-for-pentest.git vps
cd vps
```

#### 2.- Credentials

- Create credentials folder

    ```console
    mkdir credentials
    ```

##### Google Cloud Platform

- Create a folder called "credentials"
- Create project
- Create service account with "Compute Admin" role and download a key in json format.
- Enable "Compute Engine API" for the project

##### Digital Ocean

- Create a token

##### SSH Private and Public keys

#### 3.- Terraform

```console
$ terraform init
Terraform has been successfully initialized!

$ terraform apply -auto-approve
Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
Outputs:
external_ip = x.x.x.x

$ ssh aaaguirre@x.x.x.x -i ../credentials/pentest
```

#### 4.- Ansible

```console
$ ansible-playbook playbook.yaml
TASK [Configuration finished] *******************************************************
ok: [x.x.x.x] => {
    "msg": "System configured correctly."
}
```
