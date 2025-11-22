# Tunnel Resource Example
# Create tunnel in a given namespace. If one already exist it will give a error.

# Basic Tunnel configuration
resource "f5xc_tunnel" "example" {
  name      = "my-tunnel"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Tunnel configuration
  remote_ip_address = "203.0.113.1"
  local_ip_address  = "203.0.113.2"

  # IPsec tunnel
  ipsec {
    psk = "pre-shared-key-here"
    ike_params {
      ike_version = "IKE_V2"
    }
  }

  # Site reference
  site {
    name      = "my-site"
    namespace = "system"
  }
}
