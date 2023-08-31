# diffusion-infrastructure

Stable Diffusion enabled by AUTOMATIC1111 Web UI

The infrastructure spun up in this repo isn't free. Consider the cost and adjust the instance type as needed.
AWS is usually giving away free credits to new accounts so take advantage of that if you can.

## Tour of the repo

Terraform code is spread out at the root of the repo. 

All the AMI code / config stuff is in the packer directory.

## Pre-reqs
- AWS Account and AWS Credentials
- Hashicorp Terraform
- Hashicorp Packer

Running the terraform code.

```
terraform init
terraform plan
terraform apply
```

Building the AMI.

```
cd packer
packer build ubuntu.pkr.hcl
```
