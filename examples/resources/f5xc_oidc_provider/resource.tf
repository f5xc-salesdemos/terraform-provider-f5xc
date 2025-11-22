# Oidc Provider Resource Example
# CustomCreateSpecType is the spec to create oidc provider

# Basic Oidc Provider configuration
resource "f5xc_oidc_provider" "example" {
  name      = "my-oidc-provider"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Azure OIDC Spec Type. AzureOIDCSpecType specifies the att...
    azure_oidc_spec_type {
      # Configure azure_oidc_spec_type settings
    }
    # Google OIDC Spec Type. GoogleOIDCSpecType specifies the a...
    google_oidc_spec_type {
      # Configure google_oidc_spec_type settings
    }
    # OpenID Connect v1.0 Spec Type. OIDCV10SpecType specifies ...
    oidc_v10_spec_type {
      # Configure oidc_v10_spec_type settings
    }
}
