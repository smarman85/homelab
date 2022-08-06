provider "aws" {
    region = "us-west-1"
    profile = "homelab"
}

module "homelabVPC" {
    source = "../modules/aws/vpc"
    vpcCIDR = "10.0.0.0/16"
    vpcUse = "homelab2"
    publicSubnets = "10.0.0.0/20"
    publicAZ = "us-west-1a"
    privateSubnets = "10.0.16.0/20"
    privateAZ = "us-west-1c"
    // subnets = {
    //     subnet1 = {
    //         cidr = "10.0.0.0/20"
    //         public = true
    //         az = "us-west-1a"
    //     }
    //     subnet2 = {
    //         cidr = "10.0.16.0/20"
    //         public = false
    //         az = "us-west-1c"
    //     }
    // }
}

resource "aws_key_pair" "west" {
    key_name = "us-west-new"
    public_key = "${file("../keys/us-west-new.pub")}"
}

resource "aws_security_group" "web" {
    name = "web_access"
    description = "Allow access from the web"
    vpc_id = module.homelabVPC.vpcID

    ingress {
        description = "ssh from everywhere"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "web from everwhere"
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

module "asg-1" {
    source = "../modules/aws/asg"

    // Launch Config
    ImageID = "ami-0d9858aa3c6322f73" // yum based image
    // ImageID = "ami-085284d24fe829cd0" // needs work
    ImageType = "t2.micro"
    SecurityGroup = [aws_security_group.web.id]
    AccessKey = aws_key_pair.west.key_name 
    // UserData = base64encode(file("../scripts/docker.sh")) // ubuntu
    UserData = base64encode(file("../scripts/docker-amazon.sh"))
    AssignPublicIP = true

    // Asg
    Desired = 2
    Max = 2
    Min = 1
    VPCZones = [module.homelabVPC.publicSubID]
    // VPCZones = module.homelabVPC.subnetIDS["subnet1"]
}
