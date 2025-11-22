# Ike Phase1 Profile Resource Example
# Shape of the IKE Phase1 profile specification

# Basic Ike Phase1 Profile configuration
resource "f5xc_ike_phase1_profile" "example" {
  name      = "my-ike-phase1-profile"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Hours. Input Hours
    ike_keylifetime_hours {
      # Configure ike_keylifetime_hours settings
    }
    # Minutes. Set IKE Key Lifetime in minutes
    ike_keylifetime_minutes {
      # Configure ike_keylifetime_minutes settings
    }
    # Empty. This can be used for messages where no values are ...
    reauth_disabled {
      # Configure reauth_disabled settings
    }
}
