aws_region          = "us-east-1"

ami_id              = "ami-002192a70217ac181"
instance_type       = "t3.small"
instance_name       = "firoz-instance"

vpc_cidr            = "10.0.0.0/16"
subnet_cidr         = "10.0.1.0/24"
availability_zone   = "us-east-1a"

route_cidr          = "0.0.0.0/0"
ingress_cidr        = "0.0.0.0/0"
egress_cidr         = "0.0.0.0/0"

vpc_name            = "terraform-vpc"
subnet_name         = "terraform-subnet"
igw_name            = "terraform-igw"
security_group_name = "terraform-sg"