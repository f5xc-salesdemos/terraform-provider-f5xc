# Ike Phase2 Profile Resource Example
# Shape of the IKE Phase2 profile specification

# Basic Ike Phase2 Profile configuration
resource "f5xc_ike_phase2_profile" "example" {
  name      = "my-ike-phase2-profile"
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
