# Ip Prefix Set Resource Example
# Create ip_prefix_set creates a new object in the storage backend for metadata.namespace.

# Basic Ip Prefix Set configuration
resource "f5xc_ip_prefix_set" "example" {
  name      = "my-ip-prefix-set"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # IP Prefix Set configuration
  prefix = ["192.168.1.0/24", "10.0.0.0/8"]
}
