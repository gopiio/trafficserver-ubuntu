data "aws_ssm_parameter" "private_subnets" {
  name = "/vpc/main/subnet/private/ids"
}

//Get Public SubnetIDs
data "aws_ssm_parameter" "public_subnets" {
  name = "/vpc/main/subnet/public/ids"
}

//Get VPC
data "aws_ssm_parameter" "vpc" {
  name = "/vpc/main/id"
}

data "aws_ssm_parameter" "r53_zone_id" {
  provider = aws.us-east-1
  name     = "/route53/main/hosted-zone/id"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

data "aws_secretsmanager_secret" "ec2_key_pair" {
  arn = local.ec2_key_pair_secret_arn
}

data "aws_secretsmanager_secret_version" "value" {
  secret_id = data.aws_secretsmanager_secret.ec2_key_pair.id
}
