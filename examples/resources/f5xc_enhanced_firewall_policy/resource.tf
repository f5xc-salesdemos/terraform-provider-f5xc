# Enhanced Firewall Policy Resource Example
# Shape of Enhanced Firewall Policy specification

# Basic Enhanced Firewall Policy configuration
resource "f5xc_enhanced_firewall_policy" "example" {
  name      = "my-enhanced-firewall-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Enhanced Firewall Policy configuration
  rule_list {
    rules {
      metadata {
        name = "allow-web-traffic"
      }
      allow {}
      advanced_action {
        action = "LOG"
      }
      source_prefix_list {
        ip_prefix_set {
          name      = "trusted-ips"
          namespace = "system"
        }
      }
      all_traffic {}
    }
  }
}

# Advanced Enhanced Firewall Policy with additional configuration
resource "f5xc_enhanced_firewall_policy" "advanced" {
  name      = "advanced-enhanced-firewall-policy"
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
