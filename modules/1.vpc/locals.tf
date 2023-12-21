locals { 
    subnets = cidrsubnets(var.vpc_cidr, 8, 8, 8, 8, 8,8 )
    #subnets = local.subnets[1]
    public_sn   = [local.subnets[0], local.subnets[1]]
    private_sn  = [local.subnets[2], local.subnets[3]]
    az1 = data.aws_availability_zones.available.names[0]
    az2 = data.aws_availability_zones.available.names[1]
}
