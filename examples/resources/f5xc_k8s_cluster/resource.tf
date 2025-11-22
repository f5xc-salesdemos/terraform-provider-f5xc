# K8s Cluster Resource Example
# Create k8s_cluster will create the object in the storage backend for namespace metadata.namespace

# Basic K8s Cluster configuration
resource "f5xc_k8s_cluster" "example" {
  name      = "my-k8s-cluster"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Kubernetes Cluster configuration
  # Use custom local domain
  use_custom_cluster_role_bindings {
    cluster_role_bindings {
      name      = "admin-binding"
      namespace = "system"
    }
  }

  cluster_wide_app_list {
    cluster_wide_apps {
      name      = "nginx-ingress"
      namespace = "system"
    }
  }

  local_access_config {
    local_domain = "cluster.local"
    default_port {}
  }

  global_access_enable {}
}

# Advanced K8s Cluster with additional configuration
resource "f5xc_k8s_cluster" "advanced" {
  name      = "advanced-k8s-cluster"
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
