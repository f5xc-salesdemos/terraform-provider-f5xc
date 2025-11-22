# Alert Receiver Resource Example
# Creates a new Alert Receiver object

# Basic Alert Receiver configuration
resource "f5xc_alert_receiver" "example" {
  name      = "my-alert-receiver"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Alert Receiver configuration
  # Slack configuration
  slack {
    url = "https://your-slack-webhook-url"
  }
}
