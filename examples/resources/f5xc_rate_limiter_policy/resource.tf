# Rate Limiter Policy Resource Example
# Shape of the Rate Limiter Policy Create specification

# Basic Rate Limiter Policy configuration
resource "f5xc_rate_limiter_policy" "example" {
  name      = "my-rate-limiter-policy"
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
    any_server {
      # Configure any_server settings
    }
    # Rules. A list of RateLimiterRules that are evaluated sequ...
    rules {
      # Configure rules settings
    }
}
