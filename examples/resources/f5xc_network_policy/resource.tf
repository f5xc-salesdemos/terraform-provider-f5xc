# Network Policy Resource Example
# Creates a new network policy with configured parameters in specified namespace

# Basic Network Policy configuration
resource "f5xc_network_policy" "example" {
  name      = "my-network-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Network Policy configuration
  endpoint {
    any {}
  }

  ingress_rules {
    metadata {
      name = "allow-http"
    }
    spec {
      action = "ALLOW"
      any   = {}
    }
  }

  egress_rules {
    metadata {
      name = "allow-all-egress"
    }
    spec {
      action = "ALLOW"
      any   = {}
    }
  }
}

# Advanced Network Policy with additional configuration
resource "f5xc_network_policy" "advanced" {
  name      = "advanced-network-policy"
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
