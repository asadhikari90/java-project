resource "aws_key_pair" "deployer" {
  key_name   = var.keyname
  public_key = var.publickey
}