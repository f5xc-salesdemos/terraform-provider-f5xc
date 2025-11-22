# Dc Cluster Group Resource Example
# Create DC Cluster group in given namespace

# Basic Dc Cluster Group configuration
resource "f5xc_dc_cluster_group" "example" {
  name      = "my-dc-cluster-group"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # DC Cluster Group Mesh Type. Details of DC Cluster Group M...
    type {
      # Configure type settings
    }
    # Empty. This can be used for messages where no values are ...
    control_and_data_plane_mesh {
      # Configure control_and_data_plane_mesh settings
    }
    # Empty. This can be used for messages where no values are ...
    data_plane_mesh {
      # Configure data_plane_mesh settings
    }
}
