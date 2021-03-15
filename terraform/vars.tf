variable "key_name" {
  description = "Desired name of AWS key pair"
}


variable "access_key" {}
variable "secret_key" {}
variable "region" {
  default = "us-east-1"
}

# Red Hat Enterprise Linux 8 (HVM), SSD Volume Type
variable "amis" {
  type = map
  default = {
    "us-east-1" = "ami-096fda3c22c1c990a"
    "ap-south-1" = "ami-0a9d27a9f4f5c0efc"
  }
}
