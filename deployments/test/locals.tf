locals {
  region                  = "us-east-2"
  name                    = "trafficserver-builder"
  ec2_key_pair_secret_arn = "arn:aws:secretsmanager:us-east-2:401053150791:secret:ec2/key-pair/nonprod-a8jsWG"
  keypair_name            = "NebulaOps"
  private_key             = base64decode(jsondecode(data.aws_secretsmanager_secret_version.value.secret_string)["private_key"])
  allowed_ips = [
    "157.166.0.0/16",
    "168.161.18.1/32",
    "157.166.1.4/32",
    "168.161.22.1/32",
    "168.161.12.39/32",
    "168.161.25.4/32",
    "168.161.251.249/32",
    "18.228.83.72/32",
    "18.230.44.12/32",
    "206.208.182.65/32",
    "168.161.212.233/32",
    "157.166.228.113/32",
    "157.166.228.115/32",
    "195.183.156.2/32",
    "185.60.71.12/32",
    "185.139.217.10/32"
  ]
  vpc_eips = [
    "3.13.66.11/32",
    "3.132.206.26/32",
    "3.133.65.190/32"
  ]
  tags = {
    Name          = "trafficserver-builder"
    application   = "ansible"
    contact-email = "adam.gilman@warnermedia.com"
    customer      = "hbomax"
    environment   = "dev"
    team          = "nebula"
    is_delete     = "true"
  }
}
