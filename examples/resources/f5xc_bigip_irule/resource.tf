# Bigip Irule Resource Example
# Desired state for BIG-IP iRule Service

# Basic Bigip Irule configuration
resource "f5xc_bigip_irule" "example" {
  name      = "my-bigip-irule"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
