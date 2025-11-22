# Api Discovery Resource Example
# Create api discovery creates a new object in the storage backend for metadata.namespace.

# Basic Api Discovery configuration
resource "f5xc_api_discovery" "example" {
  name      = "my-api-discovery"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Custom Authentication Types. Select your custom authentic...
    custom_auth_types {
      # Configure custom_auth_types settings
    }
}
