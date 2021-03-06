variable "access_key" {
  description = "AWS access key."
}

variable "secret_key" {
  description = "AWS secret key."
}

variable "allowed_network" {
  description = "The CIDR of network that is allowed to ssh to the servers"
}

variable "key_name" {
  description = "Name of the keypair to use in EC2."
}

variable "zone_name" {
  description = "Name of your DNS hosted zone, this can be a subdomain as well"
}

variable "manager_type" {
  description = "UCP manager instance type"
}

variable "manager_count" {
  description = "Number of UCP manager nodes (3,5,7)"
  default     = "3"
}

variable "worker_type" {
  description = "UCP worker instance type"
}

variable "worker_count" {
  description = "Number of UCP worker nodes"
  default     = "3"
}

variable "ucp_dns" {
  description = "UCP DNS name"
}

variable "dtr_dns" {
  description = "UCP DNS name"
}

variable "env_name" {
  type        = "string"
  description = "Environment name"
}

variable "region" {
  type        = "string"
  description = "The AWS region to create things in."
  default     = "us-west-2"
}

variable "vpc_cidr" {
  type        = "string"
  description = "CIDR for VPC"
  default     = "192.168.0.0/16"
}

variable "public_cidrs" {
  type        = "map"
  description = "CIDR for public subnets"
  default     = {
    "0" = "192.168.10.0/24"
    "1" = "192.168.20.0/24"
    "2" = "192.168.30.0/24"
  }
}

# Note: This mapping has to be updated manually, terraform didn't allow interpolated variables here

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
