# Alert Policy Resource Example
# Creates a new Alert Policy Object

# Basic Alert Policy configuration
resource "f5xc_alert_policy" "example" {
  name      = "my-alert-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Alert Policy configuration
  # Alert receivers
  receivers {
    name      = "slack-receiver"
    namespace = "system"
  }

  # Alert routes
  routes {
    any {}
    send {}
  }

  # Notification parameters
  notification_parameters {
    default {}
    group_wait     = "30s"
    group_interval = "1m"
  }
}
