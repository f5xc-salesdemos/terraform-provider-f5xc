# Bgp Resource Example
# BGP object is the configuration for peering with external BGP servers. It is created by users in system namespace.

# Basic Bgp configuration
resource "f5xc_bgp" "example" {
  name      = "my-bgp"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # BGP configuration
  bgp_router_id = "192.168.1.1"

  bgp_peers {
    metadata {
      name = "upstream-peer"
    }
    spec {
      peer_asn = 65000
      peer_address = "192.168.1.2"
    }
  }

  local_asn = 65001

  # Site reference
  site {
    name      = "my-site"
    namespace = "system"
  }
}
