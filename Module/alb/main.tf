resource "aws_lb" "companyname_alb" {
    name               = "companyname-alb"
    load_balancer_type = "application"
    security_groups    = [var.alb_sg_id]
    subnets            = [var.public_subnet_id[0].id, var.public_subnet_id[1].id]
    enable_deletion_protection = true
}

resource "aws_lb_target_group" "alb_tg_ec2" {
    name     = "companyname-alb-tg-ec2"
    port     = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id   = var.vpc_id
}

# resource "aws_lb_listener" "alb_listener_ec2" {
#     load_balancer_arn = aws_lb.companyname_alb.id
#     port     = "80"
#     protocol = "HTTP"

#     default_action {
#         type = "forward"
#         target_group_arn = aws_lb_target_group.alb_tg_ec2.id
#     }
# }

resource "aws_lb_target_group" "alb_tg_ec2_gpu" {
    name     = "micae-alb-tg-ec2-gpu"
    port     = 80
    protocol = "HTTP"
    target_type = "ip"
    vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "alb_listener_ec2_gpu" {
    load_balancer_arn = aws_lb.companyname_alb.id
    port     = "80"
    protocol = "HTTP"

    default_action {
        type = "forward"
        target_group_arn = aws_lb_target_group.alb_tg_ec2_gpu.id
    }
}