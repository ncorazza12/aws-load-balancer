# User data
data "template_file" "user_data" {
  template = file(var.user_data_script)
}

# EC2 Instances
resource "aws_instance" "this" {
  count                  = length(var.subnet_ids)
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids[count.index]
  vpc_security_group_ids = [var.security_group_id]
  user_data_base64       = base64encode(data.template_file.user_data.rendered)
  key_name               = var.key_name
  tags = {
    Name = "EC2-${count.index + 1}"
  }
}

# Load Balancer Target Group
resource "aws_lb_target_group" "this" {
  name     = "ec2-lb-tg"
  protocol = "HTTP"
  port     = 80
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-399"
  }
}

# Attach EC2 to Target Group
resource "aws_lb_target_group_attachment" "this" {
  for_each         = { for idx, inst in aws_instance.this : idx => inst }
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value.id
  port             = 80
}

# Load Balancer
resource "aws_lb" "this" {
  name               = "ec2-lb"
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [var.security_group_id]
}

# Listener
resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

# Output do DNS do Load Balancer
output "lb_url" {
  value       = "http://${aws_lb.this.dns_name}"
  description = "URL pública do Load Balancer"
}
