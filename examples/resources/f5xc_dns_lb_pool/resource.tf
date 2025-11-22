# Dns Lb Pool Resource Example
# Create DNS Load Balancer Pool in a given namespace. If one already exist it will give a error.

# Basic Dns Lb Pool configuration
resource "f5xc_dns_lb_pool" "example" {
  name      = "my-dns-lb-pool"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Pool for A Record.
    a_pool {
      # Configure a_pool settings
    }
    # Empty. This can be used for messages where no values are ...
    disable_health_check {
      # Configure disable_health_check settings
    }
    # Object reference. This type establishes a direct referenc...
    health_check {
      # Configure health_check settings
    }
}
