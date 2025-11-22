# Virtual Site Resource Example
# Create a virtual site object in given namespace

# Basic Virtual Site configuration
resource "f5xc_virtual_site" "example" {
  name      = "my-virtual-site"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Virtual Site configuration
  site_type = "CUSTOMER_EDGE"

  # Site selector expression
  site_selector {
    expressions = ["region in (us-west-2, us-east-1)"]
  }
}
