# Addon Subscription Resource Example
# Create a new Addon Subscription with Addon Subscription State

# Basic Addon Subscription configuration
resource "f5xc_addon_subscription" "example" {
  name      = "my-addon-subscription"
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
    addon_service {
      # Configure addon_service settings
    }
    # Notification Preference. NotificationPreference preferenc...
    notification_preference {
      # Configure notification_preference settings
    }
    # Addon Subscription Associated Emails. Addon Subscription ...
    emails {
      # Configure emails settings
    }
}
