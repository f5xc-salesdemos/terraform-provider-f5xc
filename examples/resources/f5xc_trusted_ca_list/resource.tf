# Trusted Ca List Resource Example
# Shape of the Root CA Certificate specification

# Basic Trusted Ca List configuration
resource "f5xc_trusted_ca_list" "example" {
  name      = "my-trusted-ca-list"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Trusted CA List configuration
  trusted_ca_url = "string:///LS0tLS1CRUdJTi..."
}
