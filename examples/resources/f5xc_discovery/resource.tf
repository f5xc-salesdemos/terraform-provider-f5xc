# Discovery Resource Example
# API to create discovery object for a site or virtual site in system namespace

# Basic Discovery configuration
resource "f5xc_discovery" "example" {
  name      = "my-discovery"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Discovery configuration
  discovery_k8s {
    access_info {
      kubeconfig_url {
        clear_secret_info {
          url = "string:///base64-kubeconfig"
        }
      }
      isolated {}
    }
    publish_info {
      disable {}
    }
  }

  # Site selection
  where {
    site {
      ref {
        name      = "my-site"
        namespace = "system"
      }
      network_type = "VIRTUAL_NETWORK_SITE_LOCAL_INSIDE"
    }
  }
}
