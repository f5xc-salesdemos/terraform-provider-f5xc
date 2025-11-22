# Managed Tenant Resource Example
# Creates a managed_tenant config instance. Name of the object is name of the tenant that is allowed to manage.

# Basic Managed Tenant configuration
resource "f5xc_managed_tenant" "example" {
  name      = "my-managed-tenant"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Group Mapping. List of local user group association to us...
    groups {
      # Configure groups settings
    }
    # Object reference. This type establishes a direct referenc...
    group {
      # Configure group settings
    }
}
