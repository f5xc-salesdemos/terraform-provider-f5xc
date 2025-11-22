# Http Loadbalancer Resource Example
# Shape of the HTTP load balancer specification

# Basic Http Loadbalancer configuration
resource "f5xc_http_loadbalancer" "example" {
  name      = "my-http-loadbalancer"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # HTTP Load Balancer specific configuration
  domains = ["app.example.com"]

  # Advertise on public internet
  advertise_on_internet {
    default_vip {}
  }

  # Default origin server
  default_route_pools {
    pool {
      name      = "my-origin-pool"
      namespace = "system"
    }
    weight   = 1
    priority = 1
  }

  # Enable HTTP to HTTPS redirect
  http {
    dns_volterra_managed = true
  }

  # Disable rate limiting by default
  disable_rate_limit {}

  # No WAF by default
  disable_waf {}
}

# Advanced Http Loadbalancer with additional configuration
resource "f5xc_http_loadbalancer" "advanced" {
  name      = "advanced-http-loadbalancer"
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

  # Multiple domains
  domains = ["app.example.com", "www.example.com", "api.example.com"]

  # Custom advertise configuration
  advertise_custom {
    advertise_where {
      site {
        site {
          name      = "my-ce-site"
          namespace = "system"
        }
        network = "SITE_NETWORK_OUTSIDE_WITH_INTERNET_VIP"
      }
      use_default_port {}
    }
  }

  # Multiple origin pools with weights
  default_route_pools {
    pool {
      name      = "primary-pool"
      namespace = "system"
    }
    weight   = 80
    priority = 1
  }

  default_route_pools {
    pool {
      name      = "secondary-pool"
      namespace = "system"
    }
    weight   = 20
    priority = 2
  }

  # HTTPS with auto certificate
  https_auto_cert {
    http_redirect           = true
    add_hsts               = true
    tls_config {
      default_security {}
    }
    no_mtls {}
  }

  # WAF configuration
  app_firewall {
    name      = "my-waf"
    namespace = "shared"
  }

  # Service policies
  active_service_policies {
    policies {
      name      = "api-policy"
      namespace = "shared"
    }
  }

  # Rate limiting
  rate_limit {
    rate_limiter {
      name      = "api-rate-limit"
      namespace = "shared"
    }
    no_ip_allowed_list {}
  }

  # User identification
  user_identification {
    name      = "user-id"
    namespace = "shared"
  }

  # Bot defense
  bot_defense {
    policy {
      js_insert_all_pages {
        javascript_location = "AFTER_HEAD"
      }
    }
    regional_endpoint = "US"
    timeout = 1000
  }
}
