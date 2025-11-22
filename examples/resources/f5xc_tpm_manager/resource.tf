# Tpm Manager Resource Example
# Create a TPM Manager object

# Basic Tpm Manager configuration
resource "f5xc_tpm_manager" "example" {
  name      = "my-tpm-manager"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
