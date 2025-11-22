# Voltshare Admin Policy Resource Example
# Create voltshare_admin_policy creates a new object in the storage backend for metadata.namespace.

# Basic Voltshare Admin Policy configuration
resource "f5xc_voltshare_admin_policy" "example" {
  name      = "my-voltshare-admin-policy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # User Matcher. user_matcher contains contains the allow/de...
    author_restrictions {
      # Configure author_restrictions settings
    }
    # Empty. This can be used for messages where no values are ...
    allow_all {
      # Configure allow_all settings
    }
    # Custom List. Custom List contains user customized list of...
    allow_list {
      # Configure allow_list settings
    }
}
