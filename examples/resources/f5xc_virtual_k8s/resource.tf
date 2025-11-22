# Virtual K8s Resource Example
# Create virtual_k8s will create the object in the storage backend for namespace metadata.namespace

# Basic Virtual K8s configuration
resource "f5xc_virtual_k8s" "example" {
  name      = "my-virtual-k8s"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Virtual Kubernetes configuration
  # Virtual site selection
  vsite_refs {
    name      = "my-virtual-site"
    namespace = "system"
  }

  # Disable cluster global access
  disabled {}
}

# Advanced Virtual K8s with additional configuration
resource "f5xc_virtual_k8s" "advanced" {
  name      = "advanced-virtual-k8s"
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
