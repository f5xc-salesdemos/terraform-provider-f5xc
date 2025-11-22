# Secret Policy Resource Example
# Create secret_policy creates a new object in the storage backend for metadata.namespace.

# Basic Secret Policy configuration
resource "f5xc_secret_policy" "example" {
  name      = "my-secret-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Secret Policy configuration
  algo = "DENY_OVERRIDES"

  rules {
    metadata {
      name = "allow-team-secrets"
    }
    spec {
      action = "ALLOW"
      secret_match {
        regex {
          regex = "team-.*"
        }
      }
    }
  }
}
