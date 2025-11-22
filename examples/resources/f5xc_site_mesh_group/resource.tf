# Site Mesh Group Resource Example
# Create a Site Mesh Group in system namespace of user

# Basic Site Mesh Group configuration
resource "f5xc_site_mesh_group" "example" {
  name      = "my-site-mesh-group"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Site Mesh Group configuration
  type = "SITE_MESH_GROUP_TYPE_FULL_MESH"

  # Control and data plane settings
  full_mesh {
    control_and_data_plane_mesh {}
  }

  # Hub status
  hub {}

  # Virtual site reference
  virtual_site {
    name      = "my-virtual-site"
    namespace = "system"
  }
}
