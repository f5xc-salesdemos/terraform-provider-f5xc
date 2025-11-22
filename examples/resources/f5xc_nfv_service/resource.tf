# Nfv Service Resource Example
# Creates a new NFV service with configured parameters

# Basic Nfv Service configuration
resource "f5xc_nfv_service" "example" {
  name      = "my-nfv-service"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Empty. This can be used for messages where no values are ...
    disable_https_management {
      # Configure disable_https_management settings
    }
    # Empty. This can be used for messages where no values are ...
    disable_ssh_access {
      # Configure disable_ssh_access settings
    }
    # SSH based management. SSH based configuration
    enabled_ssh_access {
      # Configure enabled_ssh_access settings
    }
}
