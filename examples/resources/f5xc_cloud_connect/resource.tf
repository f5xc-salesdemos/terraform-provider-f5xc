# Cloud Connect Resource Example
# Shape of the Cloud Connect specification

# Basic Cloud Connect configuration
resource "f5xc_cloud_connect" "example" {
  name      = "my-cloud-connect"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # AWS TGW Site Type. Cloud Connect AWS TGW Site Type
    aws_tgw_site {
      # Configure aws_tgw_site settings
    }
    # Object reference. This type establishes a direct referenc...
    cred {
      # Configure cred settings
    }
    # Object reference. This type establishes a direct referenc...
    site {
      # Configure site settings
    }
}
