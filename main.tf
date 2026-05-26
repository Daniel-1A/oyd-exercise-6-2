# --- Tarea 3: Security Group del ALB ---------------------------------------
resource "aws_security_group" "alb" {
  name        = "mediastream-alb-sg"
  description = "Allow inbound HTTP traffic to the Application Load Balancer."
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = var.listener_port
    to_port     = var.listener_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "mediastream-alb-sg"
    Environment = var.environment
  }
}

# --- Tarea 4: Target Group -------------------------------------------------
resource "aws_lb_target_group" "api" {
  name        = "mediastream-api-tg"
  protocol    = "HTTP"
  port        = 80
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  tags = {
    Name        = "mediastream-api-tg"
    Environment = var.environment
  }
}

# --- Tarea 5a: Application Load Balancer -----------------------------------
resource "aws_lb" "main" {
  name               = "mediastream-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb.id]
  subnets            = data.aws_subnets.public.ids

  tags = {
    Name        = "mediastream-alb"
    Environment = var.environment
  }
}

# --- Tarea 5b: Listener ----------------------------------------------------
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}

# --- Tarea 5c: Registro de la instancia EC2 en el Target Group -------------
resource "aws_lb_target_group_attachment" "api" {
  target_group_arn = aws_lb_target_group.api.arn
  target_id        = data.aws_instance.api.id
  port             = 80
}
