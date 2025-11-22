# Nat Policy Resource Example
# NAT Policy create specification configures NAT Policy with multiple Rules,

# Basic Nat Policy configuration
resource "f5xc_nat_policy" "example" {
  name      = "my-nat-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Rule. List of rules to apply under the NAT Policy. Rule t...
    rules {
      # Configure rules settings
    }
    # Action. Action to apply on the packet if the NAT rule is ...
    action {
      # Configure action settings
    }
    # Dynamic Pool. Dynamic Pool Configuration
    dynamic {
      # Configure dynamic settings
    }
}
