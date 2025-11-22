# Tpm Api Key Resource Example
# APIKey object when successfully created returns actual APIKey bytes which is used by the users to call in to TPM provisioning API.

# Basic Tpm Api Key configuration
resource "f5xc_tpm_api_key" "example" {
  name      = "my-tpm-api-key"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # TPM Category. APIKey needs a reference to an existing TPM...
    category_ref {
      # Configure category_ref settings
    }
}
