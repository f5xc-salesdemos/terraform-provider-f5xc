# Cluster Resource Example
# Create cluster will create the object in the storage backend for namespace metadata.namespace

# Basic Cluster configuration
resource "f5xc_cluster" "example" {
  name      = "my-cluster"
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
    auto_http_config {
      # Configure auto_http_config settings
    }
    # Circuit Breaker. CircuitBreaker provides a mechanism for ...
    circuit_breaker {
      # Configure circuit_breaker settings
    }
    # Default Subset. List of key-value pairs that define defau...
    default_subset {
      # Configure default_subset settings
    }
}
