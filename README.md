# oyd-exercise-6-2 - ALB with Listener and Target Group

## Overview

This repository provisions an Application Load Balancer (ALB) in front of an existing
EC2 instance running the MediaStream transcoding API. The `setup/` directory creates
the base VPC and EC2 instance; the root workspace adds the ALB layer on top.

## Architecture
Internet -> ALB (port 80) -> Target Group -> EC2 (mediastream-api)

## Usage

### 1. Apply the setup workspace

```powershell
cd setup
terraform init
terraform apply -auto-approve
cd ..
```

### 2. Apply the root workspace

```powershell
terraform init
terraform apply -var-file=terraform.tfvars
```

## Evidence

### terraform state list
data.aws_instance.api
data.aws_subnets.public
data.aws_vpc.main
aws_lb.main
aws_lb_listener.http
aws_lb_target_group.api
aws_lb_target_group_attachment.api
aws_security_group.alb

### terraform output
alb_arn          = "arn:aws:elasticloadbalancing:us-east-1:676206925447:loadbalancer/app/mediastream-alb/07bd6baf45efdc8b"
alb_dns_name     = "mediastream-alb-2047701814.us-east-1.elb.amazonaws.com"
target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:676206925447:targetgroup/mediastream-api-tg/b4536c514f271df1"
