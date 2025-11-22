# Proxy Resource Example
# Shape of the TCP loadbalancer create specification

# Basic Proxy configuration
resource "f5xc_proxy" "example" {
  name      = "my-proxy"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Proxy configuration
  proxy_url = "http://proxy.example.com:8080"
}
