data "aws_vpc" "default" {
  default = true
}
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}
data "template_file" "ds-user-data" {
        template = file("userdata.sh")
}

