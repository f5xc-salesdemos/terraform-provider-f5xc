# Policy Based Routing Resource Example
# Shape of the Network Policy based routing create specification

# Basic Policy Based Routing configuration
resource "f5xc_policy_based_routing" "example" {
  name      = "my-policy-based-routing"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # L3/L4 routing rule. Network(L3/L4) routing policy rule
    forward_proxy_pbr {
      # Configure forward_proxy_pbr settings
    }
    # L3/L4 routing rules. Network(L3/L4) routing policy rules....
    forward_proxy_pbr_rules {
      # Configure forward_proxy_pbr_rules settings
    }
    # Empty. This can be used for messages where no values are ...
    all_destinations {
      # Configure all_destinations settings
    }
}
