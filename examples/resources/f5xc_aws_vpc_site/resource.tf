# Aws Vpc Site Resource Example
# Shape of the AWS VPC site specification

# Basic Aws Vpc Site configuration
resource "f5xc_aws_vpc_site" "example" {
  name      = "my-aws-vpc-site"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # AWS VPC Site configuration
  aws_region = "us-west-2"

  # AWS credentials reference
  aws_cred {
    name      = "aws-credentials"
    namespace = "system"
  }

  # VPC configuration
  vpc {
    new_vpc {
      name_tag     = "f5xc-vpc"
      primary_ipv4 = "10.0.0.0/16"
    }
  }

  # Instance type
  instance_type = "t3.xlarge"

  # Ingress/Egress gateway
  ingress_egress_gw {
    aws_certified_hw = "aws-byol-multi-nic-voltmesh"
    az_nodes {
      aws_az_name = "us-west-2a"
      inside_subnet {
        subnet_param {
          ipv4 = "10.0.1.0/24"
        }
      }
      outside_subnet {
        subnet_param {
          ipv4 = "10.0.2.0/24"
        }
      }
    }
  }

  # No worker nodes by default
  no_worker_nodes {}
}

# Advanced Aws Vpc Site with additional configuration
resource "f5xc_aws_vpc_site" "advanced" {
  name      = "advanced-aws-vpc-site"
  namespace = "system"

  labels = {
    environment = "staging"
    team        = "platform"
    cost_center = "engineering"
  }

  annotations = {
    "created_by" = "terraform"
    "version"    = "2.0"
  }
}
