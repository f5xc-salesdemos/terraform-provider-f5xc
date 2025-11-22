# Policer Resource Example
# Create a new policer with traffic rate limits

# Basic Policer configuration
resource "f5xc_policer" "example" {
  name      = "my-policer"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
