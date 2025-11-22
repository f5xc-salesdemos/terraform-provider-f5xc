# Irule Resource Example
# Create iRule in a given namespace. If one already exists it will give an error.

# Basic Irule configuration
resource "f5xc_irule" "example" {
  name      = "my-irule"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
