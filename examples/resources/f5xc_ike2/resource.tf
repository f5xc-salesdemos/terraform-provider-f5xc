# Ike2 Resource Example
# Shape of the IKE Phase2 profile specification

# Basic Ike2 configuration
resource "f5xc_ike2" "example" {
  name      = "my-ike2"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Diffie Hellman Groups. Choose the acceptable Diffie Hellm...
    dh_group_set {
      # Configure dh_group_set settings
    }
    # Empty. This can be used for messages where no values are ...
    disable_pfs {
      # Configure disable_pfs settings
    }
    # Hours. Input Hours
    ike_keylifetime_hours {
      # Configure ike_keylifetime_hours settings
    }
}
