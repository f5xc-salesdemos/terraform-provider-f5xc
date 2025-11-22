# Cminstance Resource Example
# Create App type will create the configuration in namespace metadata.namespace

# Basic Cminstance configuration
resource "f5xc_cminstance" "example" {
  name      = "my-cminstance"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Secret. SecretType is used in an object to indicate a sen...
    api_token {
      # Configure api_token settings
    }
    # Blindfold Secret. BlindfoldSecretInfoType specifies infor...
    blindfold_secret_info {
      # Configure blindfold_secret_info settings
    }
    # In-Clear Secret. ClearSecretInfoType specifies informatio...
    clear_secret_info {
      # Configure clear_secret_info settings
    }
}
