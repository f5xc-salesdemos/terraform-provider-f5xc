# Network Interface Resource Example
# Network interface represents configuration of a network device. It is created by users in system namespace.

# Basic Network Interface configuration
resource "f5xc_network_interface" "example" {
  name      = "my-network-interface"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Dedicated Interface. Dedicated Interface Configuration
    dedicated_interface {
      # Configure dedicated_interface settings
    }
    # Empty. This can be used for messages where no values are ...
    cluster {
      # Configure cluster settings
    }
    # Empty. This can be used for messages where no values are ...
    is_primary {
      # Configure is_primary settings
    }
}
