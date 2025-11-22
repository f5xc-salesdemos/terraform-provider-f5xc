# Rate Limiter Resource Example
# Create rate_limiter creates a new object in the storage backend for metadata.namespace.

# Basic Rate Limiter configuration
resource "f5xc_rate_limiter" "example" {
  name      = "my-rate-limiter"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Rate Limiter configuration
  total_number  = 100
  unit         = "MINUTE"
  burst_multiplier = 10
}
