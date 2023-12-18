locals { 
    subnets = cidrsubnets(var.vpc_cidr, 8, 8, 8, 8, 8, 8)
    #subnets = local.subnets[1]
    az1 = data.aws_availability_zones.available.names[0]
    az2 = data.aws_availability_zones.available.names[1]
}
