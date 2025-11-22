# Aws Tgw Site Resource Example
# Shape of the AWS TGW site specification

# Basic Aws Tgw Site configuration
resource "f5xc_aws_tgw_site" "example" {
  name      = "my-aws-tgw-site"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # AWS TGW Site configuration
  aws_region = "us-west-2"

  # AWS credentials
  aws_cred {
    name      = "aws-credentials"
    namespace = "system"
  }

  # VPC configuration
  vpc {
    new_vpc {
      name_tag     = "f5xc-tgw-vpc"
      primary_ipv4 = "10.0.0.0/16"
    }
  }

  # TGW configuration
  tgw {
    new_tgw {
      name = "f5xc-tgw"
    }
  }

  # Instance type
  instance_type = "t3.xlarge"

  # Service VPC
  services_vpc {
    aws_certified_hw = "aws-byol-voltmesh"
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
      workload_subnet {
        subnet_param {
          ipv4 = "10.0.3.0/24"
        }
      }
    }
  }

  # No worker nodes
  no_worker_nodes {}
}

# Advanced Aws Tgw Site with additional configuration
resource "f5xc_aws_tgw_site" "advanced" {
  name      = "advanced-aws-tgw-site"
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
