# Workload Flavor Resource Example
# Create a workload_flavor

# Basic Workload Flavor configuration
resource "f5xc_workload_flavor" "example" {
  name      = "my-workload-flavor"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
