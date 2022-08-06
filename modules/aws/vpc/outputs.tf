output "vpcID" {
    value = aws_vpc.main_vpc.id
}

// output "subnetIDS" {
//     value = {
//         for s in aws_subnet.vpc_subnets : s.availability_zone => s.id
//     }
// }

output "publicSubID" {
    value = aws_subnet.public.id
}

output "privateSubID" {
    value = aws_subnet.private
}