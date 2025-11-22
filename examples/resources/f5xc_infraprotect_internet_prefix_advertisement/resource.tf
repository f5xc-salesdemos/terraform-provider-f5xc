# Infraprotect Internet Prefix Advertisement Resource Example
# Creates a DDoS transit Internet Prefix

# Basic Infraprotect Internet Prefix Advertisement configuration
resource "f5xc_infraprotect_internet_prefix_advertisement" "example" {
  name      = "my-infraprotect-internet-prefix-advertisement"
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
    activation_announce {
      # Configure activation_announce settings
    }
    # Empty. This can be used for messages where no values are ...
    activation_withdraw {
      # Configure activation_withdraw settings
    }
    # Empty. This can be used for messages where no values are ...
    expiration_never {
      # Configure expiration_never settings
    }
}
