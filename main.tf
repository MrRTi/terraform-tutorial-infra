module "networking" {
  source         = "./modules/networking"
}

module "instance" {
  source         = "./modules/instance"
  ssh_key        = var.instance_key_file
  user           = var.instance_user
  instance_ami   = var.instance_ami
  ec2_sg_id      = module.networking.ec2_sg_id
}

module "application" {
  source         = "./modules/application"
  image          = var.image
  host           = "ssh://${var.instance_user}@${module.instance.public_ip}:22"
}
