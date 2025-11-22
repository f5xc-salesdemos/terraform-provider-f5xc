# Srv6 Network Slice Resource Example
# Create srv6_network_slice creates a new object in the storage backend for metadata.namespace.

# Basic Srv6 Network Slice configuration
resource "f5xc_srv6_network_slice" "example" {
  name      = "my-srv6-network-slice"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
