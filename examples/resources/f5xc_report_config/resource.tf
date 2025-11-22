# Report Config Resource Example
# Report configuration is used to schedule report generation at a later point in time.

# Basic Report Config configuration
resource "f5xc_report_config" "example" {
  name      = "my-report-config"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Report recipients. Report recipients
    report_recipients {
      # Configure report_recipients settings
    }
    # User Groups. Select one or more user groups, to which the...
    user_groups {
      # Configure user_groups settings
    }
    # Report Type Waap. Report Type Waap
    waap {
      # Configure waap settings
    }
}
