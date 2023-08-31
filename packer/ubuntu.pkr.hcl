packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

build {
  hcp_packer_registry {
    bucket_name = "aws-stable-diffusion"
    description = "Keeping stable diffusion AI images here."

    bucket_labels = {
      "owner"          = "platform-team"
      "os"             = "Ubuntu",
      "ubuntu-version" = "Focal 20.04",
    }

    build_labels = {
      "build-time"   = timestamp()
      "build-source" = basename(path.cwd)
    }
  }

  sources = [
    "source.amazon-ebs.ubuntu-gpu"
  ]

  provisioner "file" {
    source = "./config/stablediffusion.service"
    destination = "~/stablediffusion.service"
  }

  provisioner "file" {
    source = "./config/nginx.conf"
    destination = "~/nginx.conf"
  }

  provisioner "shell" {
    script = "./scripts/installation.sh"
  }

}


source "amazon-ebs" "ubuntu-gpu" {
  region = "us-east-2"
  source_ami_filter {
    filters = {
      "virtualization-type" = "hvm"
      "name"                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      "root-device-type"    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }

launch_block_device_mappings {
    device_name = "/dev/sda1"
    volume_size = 100 
    volume_type = "gp2"
    delete_on_termination = true
  }
  instance_type = "g4dn.xlarge"
  ssh_username  = "ubuntu"
  ami_name      = "packer-example-${local.timestamp}"
}
