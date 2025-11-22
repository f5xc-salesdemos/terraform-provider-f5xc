# Api Definition Resource Example
# x-required Create API Definition.

# Basic Api Definition configuration
resource "f5xc_api_definition" "example" {
  name      = "my-api-definition"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # API Definition configuration
  # OpenAPI spec
  swagger_specs = ["string:///base64-openapi-spec"]

  # Non-validation mode
  non_validation_mode {}
}
