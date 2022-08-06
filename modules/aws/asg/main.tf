resource "aws_launch_configuration" "lc" {
    image_id = var.ImageID
    instance_type = var.ImageType
    security_groups = var.SecurityGroup
    key_name = var.AccessKey
    user_data = var.UserData
    associate_public_ip_address = var.AssignPublicIP
}

resource "aws_autoscaling_group" "asg" {
    desired_capacity = var.Desired
    max_size = var.Max
    min_size = var.Min
    vpc_zone_identifier = var.VPCZones
    launch_configuration = aws_launch_configuration.lc.id
}