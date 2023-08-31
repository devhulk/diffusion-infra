
data "hcp_packer_image" "aws-stable-diffusion" {
  bucket_name     = "aws-stable-diffusion"
  channel         = "latest"
  cloud_provider  = "aws"
  region          = "us-east-2"
}

resource "aws_key_pair" "gerald_diffusion_key" {
  key_name = "gerald-diffusion-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfH6EKYF8M7/AH+62MChU2cKTy9lMALtZTpzHvdW6OSlGb9bMS/vNznZ+SYsJHmrFTvgtvuAV63M7Lp/0yzYrUWrvTQe4omsM+g2ZS2xGwbR/qKEOo9otntos42icTocvuRoLSNEsI51PDv5Xw+NKOjZ3Puqb94NyzXo2YivYq1ncxt/KALoifiuKZ9mieuskURdTw4hoCJDb6cQ9OiKXYW7zvJ3e/7mhWNv+RLEbEuT+DmAdS9JEeL2u9aTxjtHbpIcMgfX3MgGdzdY/MsWptb6NgAR3n9UHWa6yBbv/pNFGmiO3l8J8PJG/KCuSQ5T76hiP3CPk/9SsP07yJm9Kt"
}


resource "aws_instance" "diffusion_node" {
  ami           = data.hcp_packer_image.aws-stable-diffusion.cloud_image_id
  instance_type = "g4dn.xlarge"
  key_name = aws_key_pair.gerald_diffusion_key.key_name
  security_groups = ["allow_tls", "allow_http", "allow_ssh_icmp_all"]
  availability_zone = "us-east-2a"

  tags = {
    Info = "Not a Crypto Miner"
    Description = "Using for testing Hashiconf Photobooth App"
    Name = "Diffusion Node"
  }

  depends_on = [
    aws_security_group.allow_ssh_icmp_all,
    aws_security_group.allow_http,
    aws_security_group.allow_tls
  ]
}


