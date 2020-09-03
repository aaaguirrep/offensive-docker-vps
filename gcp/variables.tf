variable "ssh_public_key" {
    description = "Public key"
    type = string
    default = "../credentials/offensive.pub"
}

variable "username" {
    description = "Username"
    type = string
    default = "offensive"
}

variable "vps_number" {
    description = "Number of VPS servers"
    type = string
    default = 1
}