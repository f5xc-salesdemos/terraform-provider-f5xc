# Ike1 Resource Example
# Shape of the IKE Phase1 profile specification

# Basic Ike1 configuration
resource "f5xc_ike1" "example" {
  name      = "my-ike1"
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
