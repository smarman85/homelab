variable "ImageID" {
    type = string
    description = "amazon instance ids"
}

variable "ImageType" {
    type = string
    description = "Instance type"
}

variable "SecurityGroup" {
    type = list
    description = "Id of the security group to attach"
}

variable "AccessKey" {
    type = string
    description = "Name of the key pair"
}

variable "UserData" {
    type = string
    description = "scrtip to run on start up "
    default = ""
}

variable "AssignPublicIP" {
    type = bool
    description = "If we need to assign a public IP"
    default = false
}

variable "Desired" {
    type = number
    description = "desired number of instances"
    default = 1
}

variable "Max" {
    type = number
    description = "desired number of instances"
    default = 1
}

variable "Min" {
    type = number
    description = "desired number of instances"
    default = 1
}

variable "VPCZones" {
    type = list
    description = "subnet to deploy the instances in"
    default = []
}