# Service Policy Rule Resource Example
# Create service_policy_rule creates a new object in the storage backend for metadata.namespace.

# Basic Service Policy Rule configuration
resource "f5xc_service_policy_rule" "example" {
  name      = "my-service-policy-rule"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Empty. This can be used for messages where no values are ...
    any_asn {
      # Configure any_asn settings
    }
    # Empty. This can be used for messages where no values are ...
    any_client {
      # Configure any_client settings
    }
    # Empty. This can be used for messages where no values are ...
    any_ip {
      # Configure any_ip settings
    }
}
