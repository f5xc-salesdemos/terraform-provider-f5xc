# Certificate Resource Example
# Shape of the Certificate specification

# Basic Certificate configuration
resource "f5xc_certificate" "example" {
  name      = "my-certificate"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Certificate configuration
  certificate_url = "string:///LS0tLS1CRUdJTi..."
  private_key {
    clear_secret_info {
      url = "string:///LS0tLS1CRUdJTi..."
    }
  }
}
