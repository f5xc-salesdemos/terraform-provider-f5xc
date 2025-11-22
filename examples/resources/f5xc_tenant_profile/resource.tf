# Tenant Profile Resource Example
# Creates a tenant_profile config instance. Name of the object is the name of the tenant profile to be created.

# Basic Tenant Profile configuration
resource "f5xc_tenant_profile" "example" {
  name      = "my-tenant-profile"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Child Tenant Groups. List of user groups to be created on...
    ct_groups {
      # Configure ct_groups settings
    }
    # Namespace Roles. [x-example: 'monitor, system:monitor-rol...
    namespace_roles {
      # Configure namespace_roles settings
    }
    # File. Contains file data
    favicon {
      # Configure favicon settings
    }
}
