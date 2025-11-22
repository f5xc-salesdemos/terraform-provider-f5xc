# Cloud Link Resource Example
# Creates a new CloudLink with configured parameters

# Basic Cloud Link configuration
resource "f5xc_cloud_link" "example" {
  name      = "my-cloud-link"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Amazon Web Services(AWS) CloudLink Provider. CloudLink fo...
    aws {
      # Configure aws settings
    }
    # Object reference. This type establishes a direct referenc...
    aws_cred {
      # Configure aws_cred settings
    }
    # Bring Your Own Connections. List of Bring You Own Connection
    byoc {
      # Configure byoc settings
    }
}
