# Tenant Configuration Resource Example
# Shape of the tenant configuration specification

# Basic Tenant Configuration configuration
resource "f5xc_tenant_configuration" "example" {
  name      = "my-tenant-configuration"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # BasicConfiguration.
    basic_configuration {
      # Configure basic_configuration settings
    }
    # BruteForceDetectionSettings.
    brute_force_detection_settings {
      # Configure brute_force_detection_settings settings
    }
    # PasswordPolicy.
    password_policy {
      # Configure password_policy settings
    }
}
