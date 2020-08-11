variable "ssh_public_key" {
    description = "Public key"
    type = string
    default = "../credentials/pentest.pub"
}

variable "username" {
    description = "Username"
    type = string
    default = "username"
}