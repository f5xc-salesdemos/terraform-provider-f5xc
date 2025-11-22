# Contact Resource Example
# Creates a new customer's contact detail record with us, including address and phone number.

# Basic Contact configuration
resource "f5xc_contact" "example" {
  name      = "my-contact"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
