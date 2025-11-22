# Dns Domain Resource Example
# Create DNS Domain in a given namespace. If one already exist it will give a error.

# Basic Dns Domain configuration
resource "f5xc_dns_domain" "example" {
  name      = "my-dns-domain"
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
    volterra_managed {
      # Configure volterra_managed settings
    }
}
