
data "hcp_packer_image" "aws-stable-diffusion" {
  bucket_name     = "aws-stable-diffusion"
  channel         = "latest"
  cloud_provider  = "aws"
  region          = "us-east-2"
}

// You need to populate your own keypair here and insert public key
// if you want to ssh into the EC2 instance
resource "aws_key_pair" "your_key_pair" {
  key_name = ""
  public_key = ""
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


