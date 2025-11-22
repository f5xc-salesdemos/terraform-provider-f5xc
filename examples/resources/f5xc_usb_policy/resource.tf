# Usb Policy Resource Example
# Creates a new USB policy object

# Basic Usb Policy configuration
resource "f5xc_usb_policy" "example" {
  name      = "my-usb-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Allowed USB devices. List of allowed USB devices Required...
    allowed_devices {
      # Configure allowed_devices settings
    }
}
