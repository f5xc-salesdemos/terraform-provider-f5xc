# K8s Cluster Role Resource Example
# Create k8s_cluster_role will create the object in the storage backend for namespace metadata.namespace

# Basic K8s Cluster Role configuration
resource "f5xc_k8s_cluster_role" "example" {
  name      = "my-k8s-cluster-role"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Label Selector. This type can be used to establish a 'sel...
    k8s_cluster_role_selector {
      # Configure k8s_cluster_role_selector settings
    }
    # Policy Rule List. List of rules for role permissions
    policy_rule_list {
      # Configure policy_rule_list settings
    }
    # Policy Rules. List of rules for role permissions Required...
    policy_rule {
      # Configure policy_rule settings
    }
}
