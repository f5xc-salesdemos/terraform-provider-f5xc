# Data Type Resource Example
# Create data_type creates a new object in the storage backend for metadata.namespace.

# Basic Data Type configuration
resource "f5xc_data_type" "example" {
  name      = "my-data-type"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Data Type Rules. Configure key/value or regex match rules...
    rules {
      # Configure rules settings
    }
    # Rule Pattern Type. test
    key_pattern {
      # Configure key_pattern settings
    }
    # Exact Values. List of exact values to match.
    exact_values {
      # Configure exact_values settings
    }
}
