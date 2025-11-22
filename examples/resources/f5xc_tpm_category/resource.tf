# Tpm Category Resource Example
# Create a Category object, which is a grouping of APIKeys used for TPM provisioning

# Basic Tpm Category configuration
resource "f5xc_tpm_category" "example" {
  name      = "my-tpm-category"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # TPM Manager reference. Reference to TPM Manager Required:...
    tpm_manager_ref {
      # Configure tpm_manager_ref settings
    }
}
