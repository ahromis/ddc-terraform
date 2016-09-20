variable "access_key" {
  description = "AWS access key."
}

variable "secret_key" {
  description = "AWS secret key."
}

variable "allowed_network" {
  description = "The CIDR of network that is allowed to access the bastion host"
}

variable "key_name" {
  description = "Name of the keypair to use in EC2."
  default = "hromis"
}

variable "ucp_dns" {
  description = "UCP DNS name"
  default     = "ucp.hromis.dckr.org"
}

variable "dtr_dns" {
  description = "UCP DNS name"
  default     = "dtr.hromis.dckr.org"
}

variable "env_name" {
  type        = "string"
  description = "AWS region"
  default     = "hromis-test"
}

variable "region" {
  type        = "string"
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "vpc_cidr" {
  type        = "string"
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "public_cidrs" {
  type        = "map"
  description = "CIDR for public subnets"
  default     = {
    "0" = "10.0.0.0/24"
    "1" = "10.0.10.0/24"
    "2" = "10.0.20.0/24"
  }
}

variable "availability_zones" {
  type        = "map"
  description = "AWS availability zones"
  default     = {
    "0" = "us-west-2a"
    "1" = "us-west-2b"
    "2" = "us-west-2c"
  }
}

variable "ubuntu_amis" {
  description = "Ubuntu 14.04 AMIs"
  default = {
    us-east-1 = "ami-8e0b9499"
    us-west-2 = "ami-70b67d10"
    us-west-1 = "ami-547b3834"
  }
}
