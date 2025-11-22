# Infraprotect Asn Resource Example
# Creates a DDoS transit ASN

# Basic Infraprotect Asn configuration
resource "f5xc_infraprotect_asn" "example" {
  name      = "my-infraprotect-asn"
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
    bgp_session_disabled {
      # Configure bgp_session_disabled settings
    }
    # Empty. This can be used for messages where no values are ...
    bgp_session_enabled {
      # Configure bgp_session_enabled settings
    }
}
