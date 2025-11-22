# App Type Resource Example
# Create App type will create the configuration in namespace metadata.namespace

# Basic App Type configuration
resource "f5xc_app_type" "example" {
  name      = "my-app-type"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # API Discovery Settings. Settings specifying how API Disco...
    business_logic_markup_setting {
      # Configure business_logic_markup_setting settings
    }
    # Empty. This can be used for messages where no values are ...
    disable {
      # Configure disable settings
    }
    # Discovered API Settings. x-example: '2' Configure Discove...
    discovered_api_settings {
      # Configure discovered_api_settings settings
    }
}
