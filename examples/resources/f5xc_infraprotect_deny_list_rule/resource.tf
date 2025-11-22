# Infraprotect Deny List Rule Resource Example
# Creates a DDoS transit Deny List Rule

# Basic Infraprotect Deny List Rule configuration
resource "f5xc_infraprotect_deny_list_rule" "example" {
  name      = "my-infraprotect-deny-list-rule"
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
    expiration_never {
      # Configure expiration_never settings
    }
    # Empty. This can be used for messages where no values are ...
    one_day {
      # Configure one_day settings
    }
    # Empty. This can be used for messages where no values are ...
    one_hour {
      # Configure one_hour settings
    }
}
