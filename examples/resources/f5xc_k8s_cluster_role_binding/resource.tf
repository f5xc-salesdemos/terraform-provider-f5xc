# K8s Cluster Role Binding Resource Example
# Create k8s_cluster_role_binding will create the object in the storage backend for namespace metadata.namespace

# Basic K8s Cluster Role Binding configuration
resource "f5xc_k8s_cluster_role_binding" "example" {
  name      = "my-k8s-cluster-role-binding"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Object reference. This type establishes a direct referenc...
    k8s_cluster_role {
      # Configure k8s_cluster_role settings
    }
    # Subjects. List of subjects (user, group or service accoun...
    subjects {
      # Configure subjects settings
    }
    # ServiceAccountType.
    service_account {
      # Configure service_account settings
    }
}
