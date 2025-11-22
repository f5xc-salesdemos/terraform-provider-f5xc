# App Api Group Resource Example
# Create app_api_group creates a new object in the storage backend for metadata.namespace.

# Basic App Api Group configuration
resource "f5xc_app_api_group" "example" {
  name      = "my-app-api-group"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # API Group Scope BIGIP Virtual Server. Set the scope of th...
    bigip_virtual_server {
      # Configure bigip_virtual_server settings
    }
    # API Group Scope CDN Loadbalancer. Set the scope of the AP...
    cdn_loadbalancer {
      # Configure cdn_loadbalancer settings
    }
    # API Group Elements. List of API group elements with metho...
    elements {
      # Configure elements settings
    }
}
