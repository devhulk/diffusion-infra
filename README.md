# diffusion-infra (pub)

** Under Active Development **

Stable Diffusion enabled by AUTOMATIC1111 Web UI

The infrastructure spun up in this repo isn't free. Consider the cost and adjust the instance type as needed.
AWS is usually giving away free credits to new accounts so take advantage of that if you can.

## Tour of the repo

Terraform code is spread out at the root of the repo for each AWS resources that needs to be created. 

All the AMI code / config stuff is in the packer directory.

## Pre-reqs
- (AWS Account and AWS Credentials)[https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all]
- (Hashicorp Terraform)[https://www.terraform.io/]
- (Hashicorp Packer)[https://www.packer.io/]

### 1. Building the AMI.

If your new to packer you can start (here)[https://developer.hashicorp.com/packer/tutorials/aws-get-started].

```bash
cd packer
packer build ubuntu.pkr.hcl
```

You will also need to update the TF code to add your own AWS key pair if you
want to ssh into the stable diffusion instance. If you don't want/need to then
it doesn't really matter.

Also, I am using (Hashicorp Cloud)[https://www.hashicorp.com/cloud] Packer Registry to store metadata about the Amazon AMI's I'm creating.
If you don't want to use the free trial with Hashicorp Cloud Platform you will have to update the TF code 
to use the specific AMI you generate when you run 
```bash
packer build
```

### 2. Running the terraform code.

If your new to terraform you can go through a quickstart (here)[https://developer.hashicorp.com/terraform/tutorials/aws-get-started].

```bash
terraform init
terraform plan
terraform apply
```

