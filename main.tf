terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

// I'm using HCP Packer to track the AMI metadata and automatically
// pull it in to my TF config.
// You can remove this dep by just manually copying in the AMI ID
// or you can sign up and use HCP free trial.
provider "hcp" {}

provider "aws" {
  region = "us-east-2"
}
