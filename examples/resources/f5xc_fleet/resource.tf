# Fleet Resource Example
# Create fleet will create a fleet object in 'system' namespace of the user

# Basic Fleet configuration
resource "f5xc_fleet" "example" {
  name      = "my-fleet"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Fleet configuration
  fleet_label = "env=production"

  # Network connectors
  inside_virtual_network {
    name      = "inside-network"
    namespace = "system"
  }

  outside_virtual_network {
    name      = "outside-network"
    namespace = "system"
  }

  # Default config
  default_config {}
}

# Advanced Fleet with additional configuration
resource "f5xc_fleet" "advanced" {
  name      = "advanced-fleet"
  namespace = "system"

  labels = {
    environment = "staging"
    team        = "platform"
    cost_center = "engineering"
  }

  annotations = {
    "created_by" = "terraform"
    "version"    = "2.0"
  }
}
