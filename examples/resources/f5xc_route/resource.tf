# Route Resource Example
# Create route object in a given namespace. Route object is list of route rules. Each rule has match condition to match incoming requests and actions to take on matching requests. Virtual host object has reference to route object

# Basic Route configuration
resource "f5xc_route" "example" {
  name      = "my-route"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Route configuration
  routes {
    match {
      path {
        prefix = "/api/"
      }
    }
    route_destination {
      destinations {
        cluster {
          name      = "api-cluster"
          namespace = "system"
        }
        weight = 100
      }
    }
  }
}
