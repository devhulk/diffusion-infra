terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }

    doormat = {
      source  = "doormat.hashicorp.services/hashicorp-security/doormat"
      version = "~> 0.0.2"
    }
  }
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "gerald-tfc-business"

    workspaces {
      name = "diffusion-infrastructure"
    }
  }
}

provider "doormat" {}
provider "hcp" {}

data "doormat_aws_credentials" "creds" {
  provider = doormat

  role_arn = "arn:aws:iam::938765688536:role/gerald_tfc_doormat_role"
}

provider "aws" {
  region = "us-east-2"
  access_key = data.doormat_aws_credentials.creds.access_key
  secret_key = data.doormat_aws_credentials.creds.secret_key
  token      = data.doormat_aws_credentials.creds.token
}
