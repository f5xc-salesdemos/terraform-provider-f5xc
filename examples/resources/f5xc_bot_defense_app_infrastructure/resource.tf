# Bot Defense App Infrastructure Resource Example
# Creates Bot Defense App Infrastructure in a given namespace.

# Basic Bot Defense App Infrastructure configuration
resource "f5xc_bot_defense_app_infrastructure" "example" {
  name      = "my-bot-defense-app-infrastructure"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # F5 Hosted. Infra F5 Hosted
    cloud_hosted {
      # Configure cloud_hosted settings
    }
    # Egress. Egress Required: YES ves.io.schema.rules.message....
    egress {
      # Configure egress settings
    }
    # Ingress. Ingress Required: YES ves.io.schema.rules.messag...
    ingress {
      # Configure ingress settings
    }
}
