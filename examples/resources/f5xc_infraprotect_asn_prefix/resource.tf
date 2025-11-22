# Infraprotect Asn Prefix Resource Example
# Creates a DDoS transit Prefix

# Basic Infraprotect Asn Prefix configuration
resource "f5xc_infraprotect_asn_prefix" "example" {
  name      = "my-infraprotect-asn-prefix"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Object reference. This type establishes a direct referenc...
    asn {
      # Configure asn settings
    }
}
