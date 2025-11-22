# Segment Resource Example
# Shape of the segment specification

# Basic Segment configuration
resource "f5xc_segment" "example" {
  name      = "my-segment"
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
    disable {
      # Configure disable settings
    }
    # Empty. This can be used for messages where no values are ...
    enable {
      # Configure enable settings
    }
}
