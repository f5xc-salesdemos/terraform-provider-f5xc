# Fast Acl Resource Example
# Create a `fast_acl` object, `fast_acl` object contains rules to protect site from denial of service It has destination{destination IP, destination port) and references to `fast_acl_rule`

# Basic Fast Acl configuration
resource "f5xc_fast_acl" "example" {
  name      = "my-fast-acl"
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
    protocol_policer {
      # Configure protocol_policer settings
    }
    # Fast ACL for RE. Fast ACL definition for RE
    re_acl {
      # Configure re_acl settings
    }
    # Empty. This can be used for messages where no values are ...
    all_public_vips {
      # Configure all_public_vips settings
    }
}
