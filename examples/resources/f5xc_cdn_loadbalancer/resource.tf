# Cdn Loadbalancer Resource Example
# Shape of the CDN loadbalancer specification

# Basic Cdn Loadbalancer configuration
resource "f5xc_cdn_loadbalancer" "example" {
  name      = "my-cdn-loadbalancer"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # CDN Load Balancer configuration
  domains = ["cdn.example.com"]

  # Origin pool
  origin_pool {
    public_name {
      dns_name = "origin.example.com"
    }
    follow_origin_redirect = true
    no_tls {}
  }

  # Cache TTL settings
  cache_ttl_options {
    cache_ttl_default = "1h"
  }

  # HTTP protocol
  https_auto_cert {
    http_redirect = true
  }

  # Add location header
  add_location = true
}

# Advanced Cdn Loadbalancer with additional configuration
resource "f5xc_cdn_loadbalancer" "advanced" {
  name      = "advanced-cdn-loadbalancer"
  namespace = "system"

  labels = {
    environment = "staging"
    team        = "platform"
    cost_center = "engineering"
  }

  annotations = {
    "created_by" = "terraform"
    "version"    = "2.0"
  }
}
