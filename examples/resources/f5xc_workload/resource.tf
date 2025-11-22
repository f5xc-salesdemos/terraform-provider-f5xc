# Workload Resource Example
# Shape of Workload

# Basic Workload configuration
resource "f5xc_workload" "example" {
  name      = "my-workload"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Workload configuration
  # Container configuration
  containers {
    name = "web"
    image {
      name       = "nginx"
      public     = {}
      pull_policy = "IMAGE_PULL_POLICY_ALWAYS"
    }
  }

  # Deploy on regional edge
  deploy_on_re {
    virtual_site {
      name      = "my-virtual-site"
      namespace = "system"
    }
  }
}

# Advanced Workload with additional configuration
resource "f5xc_workload" "advanced" {
  name      = "advanced-workload"
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
