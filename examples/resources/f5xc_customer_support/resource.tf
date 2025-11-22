# Customer Support Resource Example
# Creates a new customer support ticket in our customer support provider system.

# Basic Customer Support configuration
resource "f5xc_customer_support" "example" {
  name      = "my-customer-support"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Comments. Comments are all public comments on an issue. T...
    comments {
      # Configure comments settings
    }
    # Attachments details. Information about any attachments (s...
    attachments_info {
      # Configure attachments_info settings
    }
    # Ticket which this one relates to. Optional reference to a...
    relates_to {
      # Configure relates_to settings
    }
}
