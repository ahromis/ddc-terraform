# ddc-terraform
terraform repository for DDC testing

## Prerequisites

1. Install terraform on your machine <https://www.terraform.io/>
2. Make sure you have an AWS account
3. Install `awscli` on your machine

Setup `awscli`:

```
$ aws configure
AWS Access Key ID [None]: <YOUR ACCESS KEY>
AWS Secret Access Key [None]: <YOUR SECRET KEY>
Default region name [None]: us-west-2
Default output format [None]:
```

Create a file in this repo called `terraform.tfvars` with contents like this:

```
access_key = "YOUR ACCESS KEY"
secret_key = "YOUR SECRET KEY"
allowed_network = "YOUR NETWORK CIDR"
```

The CIDR should be your currrent IP address, or a list of them to restrict SSH access.

Make sure you have an SSH key imported into EC2.

```
aws ec2 import-key-pair --public-key-material file://~/.ssh/id_rsa.pub --key-name <key_name>

```

Fill out `variables.tf` with variables you wish to use for your environment. If you don't you'll be prompted for variables on `terraform apply`.
You can do that by adding in `default = <value>` in the `variables.tf` file for the variables that don't have a `default.`

## Usage

First verify the changes it's about to make with a `terraform plan`.

Then simply do a `terraform apply` from this repo.

To tear down the environment do a `terraform destroy`. Keeping instances running costs money, so it can be a good idea to destroy your environment when you are done testing.
