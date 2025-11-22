# Bgp Routing Policy Resource Example
# BGP Routing Policy is a list of rules containing match criteria and action to be applied. These rules help contol routes which are imported or exported to BGP peers

# Basic Bgp Routing Policy configuration
resource "f5xc_bgp_routing_policy" "example" {
  name      = "my-bgp-routing-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Rules. A BGP Routing policy is composed of one or more ru...
    rules {
      # Configure rules settings
    }
    # BGP Route Action. Action to be enforced if the BGP route ...
    action {
      # Configure action settings
    }
    # Empty. This can be used for messages where no values are ...
    aggregate {
      # Configure aggregate settings
    }
}
