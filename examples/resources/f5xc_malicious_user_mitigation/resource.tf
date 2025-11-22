# Malicious User Mitigation Resource Example
# Create malicious_user_mitigation creates a new object in the storage backend for metadata.namespace.

# Basic Malicious User Mitigation configuration
resource "f5xc_malicious_user_mitigation" "example" {
  name      = "my-malicious-user-mitigation"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Malicious User Mitigation configuration
  # Detection rules
  rules {
    threat_level = "HIGH"
    mitigation_action {
      block {
        body = "Access denied"
        status = "403"
      }
    }
  }
}
