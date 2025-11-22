# Api Crawler Resource Example
# Manages a APICrawler in F5 Distributed Cloud.

# Basic Api Crawler configuration
resource "f5xc_api_crawler" "example" {
  name      = "my-api-crawler"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # API Crawler. API Crawler Configuration Required: YES ves....
    domains {
      # Configure domains settings
    }
    # Simple Login.
    simple_login {
      # Configure simple_login settings
    }
    # Secret. SecretType is used in an object to indicate a sen...
    password {
      # Configure password settings
    }
}
