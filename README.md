# diffusion-infra (pub)

** Under Active Development **
Using AUTOMATIC1111 Web UI

### Disclaimer 
The infrastructure spun up in this repo isn't free. Consider the cost and adjust the instance type as needed.
AWS is usually giving away free credits to new accounts so take advantage of that if you can.

## Tour of the repo

Terraform code is spread out at the root of the repo for each AWS resources that needs to be created. 

All the AMI code / config stuff is in the packer directory.

## Pre-reqs
- [AWS Account and AWS Credentials](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)
- [Hashicorp Terraform](https://www.terraform.io/)
- [Hashicorp Packer](https://www.packer.io/)

### 1. Building the AMI.

If your new to packer you can start [here](https://developer.hashicorp.com/packer/tutorials/aws-get-started).

```bash
cd packer
packer build ubuntu.pkr.hcl
```

You will also need to update the TF code to add your own AWS key pair if you
want to ssh into the stable diffusion instance. If you don't want/need to then
it doesn't really matter.

Also, I am using [Hashicorp Cloud](https://www.hashicorp.com/cloud) Packer Registry to store metadata about the Amazon AMI's I'm creating.
If you don't want to use the free trial with Hashicorp Cloud Platform you will have to update the TF code 
to use the specific AMI you generate when you run 
```bash
packer build
```

### 2. Running the terraform code.

If your new to terraform you can go through a quickstart [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started).

```bash
terraform init
terraform plan
terraform apply
```

### Gotchas and Logging

Currently when you follow the instructions the instance is up and still installing deps. Takes a few minutes and you will get
a Bad Gateway nginx error when you visit http://{YOUR_EC2_DNS_NAME}.

Currently I'm only enabling http. If someone wants to test and submit a PR setting up lets encrpyt and nginx or something
feel free. Otherwise I'll get to it when it becomes a problem. 

If you choose to add your ssh key you can see the logs by tailing them out.

```bash
ssh -i your_key_pair.pem ubuntu@{YOUR_EC2_DNS_NAME}
tail -f /var/log/sdwebui.log
```

