# get ubuntu 22.04 ami id - it differs for each region
# data source - query information from exiting resources or external resources
data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

# data to fetch all az
data "aws_availability_zones" "aws_zones" {
  state = "available"
}

# create launch template
resource "aws_launch_template" "my-lt" {
  name          = "my-lt-${var.env}"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = "akilans.cloud"

  user_data = file("${path.module}/install-server.sh")

  tags = {
    "env" = var.env
  }

  lifecycle {
    create_before_destroy = true
  }

}

# data to fetch all the sg
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}


# security group to allow HTTP from ALB
resource "aws_security_group" "allow_http_alb" {
  name        = "alb_http_sg"
  description = "Allow HTTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from outside"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "alb_http_sg"
    env  = var.env
  }
}

# create ALB
resource "aws_lb" "my-alb" {
  name            = "my-alb"
  security_groups = [aws_security_group.allow_http_alb.id]
  subnets         = data.aws_subnets.subnets.ids

  tags = {
    env = var.env
  }
}

# create target group
resource "aws_lb_target_group" "my-tg" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# create auto scaling group
resource "aws_autoscaling_group" "my-asg" {
  availability_zones = data.aws_availability_zones.aws_zones.zone_ids
  desired_capacity   = var.desired_count
  max_size           = var.maximum_count
  min_size           = var.minimum_count
  target_group_arns  = [aws_lb_target_group.my-tg.arn]


  launch_template {
    id      = aws_launch_template.my-lt.id
    version = "$Latest"
  }
}


# create load balancer listener
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.my-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-tg.arn
  }
}
