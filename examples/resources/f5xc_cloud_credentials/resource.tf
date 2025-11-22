# Cloud Credentials Resource Example
# API to create cloud_credentials object

# Basic Cloud Credentials configuration
resource "f5xc_cloud_credentials" "example" {
  name      = "my-cloud-credentials"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Cloud Credentials configuration
  # AWS credentials example
  aws_secret_key {
    access_key = "AKIAIOSFODNN7EXAMPLE"
    secret_key {
      clear_secret_info {
        url = "string:///d0phbmVzc2VjcmV0a2V5"
      }
    }
  }
}
