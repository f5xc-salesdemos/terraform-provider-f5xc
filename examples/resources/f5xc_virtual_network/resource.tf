# Virtual Network Resource Example
# Create virtual network in given namespace

# Basic Virtual Network configuration
resource "f5xc_virtual_network" "example" {
  name      = "my-virtual-network"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Virtual Network configuration
  site_local_network {}

  # DHCP range for the network
  srv6_network {
    enterprise_network {
      srv6_network_ns_params {
        namespace = "system"
      }
    }
  }
}
