# Subnet Resource Example
# Subnet object contains configuration for an interface of a VM/pod. It is created in user or shared namespace.

# Basic Subnet configuration
resource "f5xc_subnet" "example" {
  name      = "my-subnet"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Subnet connection to Layer2 Interface.
    connect_to_layer2 {
      # Configure connect_to_layer2 settings
    }
    # Object reference. This type establishes a direct referenc...
    layer2_intf_ref {
      # Configure layer2_intf_ref settings
    }
    # Empty. This can be used for messages where no values are ...
    connect_to_slo {
      # Configure connect_to_slo settings
    }
}
