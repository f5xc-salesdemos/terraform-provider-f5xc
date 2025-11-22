# Virtual Host Resource Example
# Creates virtual host in a given namespace.

# Basic Virtual Host configuration
resource "f5xc_virtual_host" "example" {
  name      = "my-virtual-host"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Advertise Policies. Advertise Policy allows you to define...
    advertise_policies {
      # Configure advertise_policies settings
    }
    # Authentication Details. Authentication related informatio...
    authentication {
      # Configure authentication settings
    }
    # Reference to Authentication Object. Reference to Authenti...
    auth_config {
      # Configure auth_config settings
    }
}
