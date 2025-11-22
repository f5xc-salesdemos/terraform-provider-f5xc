# Data Group Resource Example
# Create data group in a given namespace. If one already exists it will give an error.

# Basic Data Group configuration
resource "f5xc_data_group" "example" {
  name      = "my-data-group"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Address Record. Data group with address record List
    address_records {
      # Configure address_records settings
    }
    # Address records. ves.io.schema.rules.map.keys.string.ip: ...
    records {
      # Configure records settings
    }
    # Integer record List. Data group with integer record List
    integer_records {
      # Configure integer_records settings
    }
}
