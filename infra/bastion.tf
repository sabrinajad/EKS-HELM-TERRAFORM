module "ec2_bastion" {
  name                   = var.ec2_name
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "3.3.0"
  ami                    = "${data.aws_ami.amzlinux2.id}"
  instance_type          = var.instance_type
  key_name               = var.instance_keypair
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastion_sg.security_group_id]
  tags = {
    vpc = "bastion-host"
  }
}


#bastion eib
resource "aws_eip" "bastion_eip" {
  depends_on = [module.ec2_bastion, module.vpc]
  instance   = module.ec2_bastion.id
  vpc        = true
  tags = {
    eip = "ec2_bastion"
  }
}


#bastion-key-provisioner
resource "null_resource" "copy_ec2_keys" {

  depends_on = [module.ec2_bastion]

  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/eks-terraform-key.pem")
  }  


  provisioner "file" {
    source      = "private-key/eks-terraform-key.pem"
    destination = "/tmp/eks-terraform-key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/eks-terraform-key.pem"
    ]
  }
}


#ami datasource
# Get latest AMI ID for Amazon Linux2 OS
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}


#bastion_security-group
module "bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.5.0"

  name = "${var.ec2_name}-sg"

  vpc_id = module.vpc.vpc_id

  ingress_rules       = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]
  tags         = local.common_tags
}