module "ec2_instance" {
  source                    = "terraform-aws-modules/ec2-instance/aws"
  version                   = "~> 3.0"
  name                      = local.name
  create_spot_instance      = true
  spot_price                = "0.60"
  spot_type                 = "persistent"
  spot_wait_for_fulfillment = true
  ami                       = data.aws_ami.ubuntu.image_id
  instance_type             = "c5.2xlarge"
  key_name                  = "NebulaOps"
  monitoring                = true
  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id,
    aws_security_group.ec2_sg_allow_metrics.id
  ]
  subnet_id                   = split(",", data.aws_ssm_parameter.public_subnets.value)[0]
  associate_public_ip_address = true

  tags = local.tags
}

resource "null_resource" "private_key" {
  provisioner "local-exec" {
    command = "echo '${local.private_key}' > /tmp/nebula-ops && chmod 600 /tmp/nebula-ops"
  }
  triggers = {
    "time" = timestamp()
  }
}

# resource "null_resource" "ansible" {
#   provisioner "local-exec" {
#     command = "echo '${module.ec2_instance.public_ip} ansible_port=22 ansible_user=ubuntu ansible_ssh_private_key_file=/tmp/nebula-ops ansible_become=true' > /tmp/trafficserver_builder"
#   }
#   triggers = {
#     "time" = timestamp()
#   }
#   depends_on = [
#     module.ec2_instance,
#     null_resource.private_key
#   ]
# }

output "public_ip" {
  value = module.ec2_instance.public_ip
}
