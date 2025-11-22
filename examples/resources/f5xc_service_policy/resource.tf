# Service Policy Resource Example
# Create service_policy creates a new object in the storage backend for metadata.namespace.

# Basic Service Policy configuration
resource "f5xc_service_policy" "example" {
  name      = "my-service-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Service Policy configuration
  algo = "FIRST_MATCH"

  # Allow specific paths
  rules {
    metadata {
      name = "allow-api"
    }
    spec {
      action = "ALLOW"
      path {
        prefix = "/api/"
      }
    }
  }
}

# Advanced Service Policy with additional configuration
resource "f5xc_service_policy" "advanced" {
  name      = "advanced-service-policy"
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
