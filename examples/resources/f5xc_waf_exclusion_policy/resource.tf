# Waf Exclusion Policy Resource Example
# Create a WAF exclusion policy

# Basic Waf Exclusion Policy configuration
resource "f5xc_waf_exclusion_policy" "example" {
  name      = "my-waf-exclusion-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # WAF Exclusion Rules. An ordered list of rules. Required: ...
    waf_exclusion_rules {
      # Configure waf_exclusion_rules settings
    }
    # Empty. This can be used for messages where no values are ...
    any_domain {
      # Configure any_domain settings
    }
    # Empty. This can be used for messages where no values are ...
    any_path {
      # Configure any_path settings
    }
}
