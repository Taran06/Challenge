# Specify the provider and access details
#provider "aws" {
#  region = "$var.aws_region"
#}


# A security group for the ELB
resource "aws_security_group" "elb" {
  name        = "terraform_example_elb"
  description = "Used in the terraform"
  vpc_id      = data.aws_vpc.default.id

  # HTTPS access from within your default VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#For our instance
resource "aws_security_group" "fornginx" {
  name        = "terraform_example"
  description = "Used in terraform"
  vpc_id      = data.aws_vpc.default.id

  # SSH access from anywhere (Obviously not the best practice for real case scenario)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "web" {
  name = "terraform-example-elb"

  subnets         = [aws_instance.web.subnet_id]
  security_groups = [aws_security_group.elb.id]
  instances       = [aws_instance.web.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_instance" "web" {
  connection {
    user = "ubuntu"

  }

  instance_type = "t2.micro"

  ami = lookup(var.amis, var.region)
  
  key_name = var.key_name

  vpc_security_group_ids = [aws_security_group.fornginx.id]

  subnet_id = sort(data.aws_subnet_ids.default.ids)[0]
  user_data = data.template_file.ds-user-data.rendered
  tags = {
    Name = "Nginx-web-server"
  }
}
