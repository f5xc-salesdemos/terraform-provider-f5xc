# User Identification Resource Example
# Create user_identification creates a new object in the storage backend for metadata.namespace.

# Basic User Identification configuration
resource "f5xc_user_identification" "example" {
  name      = "my-user-identification"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # User Identification configuration
  rules {
    identifier_type = "CLIENT_IP"
    any_client {}
  }
}
