# Tcp Loadbalancer Resource Example
# Shape of the TCP load balancer create specification

# Basic Tcp Loadbalancer configuration
resource "f5xc_tcp_loadbalancer" "example" {
  name      = "my-tcp-loadbalancer"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # TCP Load Balancer specific configuration
  listen_port = 8443

  # Advertise on public internet
  advertise_on_internet {
    default_vip {}
  }

  # Origin pools
  origin_pools_weights {
    pool {
      name      = "my-tcp-pool"
      namespace = "system"
    }
    weight = 1
  }

  # DNS for TCP load balancer
  dns_volterra_managed = true

  # No retract cluster by default
  retract_cluster {}
}

# Advanced Tcp Loadbalancer with additional configuration
resource "f5xc_tcp_loadbalancer" "advanced" {
  name      = "advanced-tcp-loadbalancer"
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
