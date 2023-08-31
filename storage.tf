/*resource "aws_ebs_volume" "diffusion_node_storage" {*/
  /*availability_zone = "us-east-2a"*/
  /*size              = 100*/
  /*tags = {*/
    /*Name = "Diffusion Node Storage"*/
  /*}*/
/*}*/

/*resource "aws_volume_attachment" "ebs_diffusion_attachment" {*/
  /*device_name = "/dev/sdh"*/
  /*volume_id   = aws_ebs_volume.diffusion_node_storage.id*/
  /*instance_id = aws_instance.diffusion_node.id*/
/*}*/
