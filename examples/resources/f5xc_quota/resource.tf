# Quota Resource Example
# Create quota creates a given object from storage backend for metadata.namespace.

# Basic Quota configuration
resource "f5xc_quota" "example" {
  name      = "my-quota"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # API Limits. API Limits defines ratelimit parameters for a...
    api_limits {
      # Configure api_limits settings
    }
    # Object Limits. Object Limits define maximum number of ins...
    object_limits {
      # Configure object_limits settings
    }
    # Resource Limits. Resource Limits define maximum value of ...
    resource_limits {
      # Configure resource_limits settings
    }
}
