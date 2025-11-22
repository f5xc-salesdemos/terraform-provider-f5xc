# Forward Proxy Policy Resource Example
# Shape of the Forward Proxy Policy specification

# Basic Forward Proxy Policy configuration
resource "f5xc_forward_proxy_policy" "example" {
  name      = "my-forward-proxy-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Forward Proxy Policy configuration
  proxy_label_selector {
    expressions = ["app in (web, api)"]
  }

  drp_http_connect {
    any_proxy {}
    rule_list {
      rules {
        metadata {
          name = "allow-external"
        }
        spec {
          action = "ALLOW"
          dst_list {
            any_dst {}
          }
        }
      }
    }
  }
}

# Advanced Forward Proxy Policy with additional configuration
resource "f5xc_forward_proxy_policy" "advanced" {
  name      = "advanced-forward-proxy-policy"
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
