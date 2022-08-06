variable "vpcCIDR" {
    type = string
    description = "CIDR range for the VPC"
}

variable "vpcUse" {
    type = string
    description = "Use for the vpc"
}

// variable "subnets" {
//     type = map(object({
//         cidr = string
//         public = bool
//         az = string
//     }))
// }

variable "publicSubnets" {
    type = string
}

variable "publicAZ" {
    type = string
}

variable "privateSubnets" {
    type = string
}

variable "privateAZ" {
    type = string
}