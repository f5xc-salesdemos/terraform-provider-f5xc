# Origin Pool Resource Example
# Shape of the origin pool create specification

# Basic Origin Pool configuration
resource "f5xc_origin_pool" "example" {
  name      = "my-origin-pool"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Origin Pool specific configuration
  origin_servers {
    public_ip {
      ip = "203.0.113.10"
    }
  }

  port = 443

  # Use TLS to origin
  use_tls {
    use_host_header_as_sni {}
    tls_config {
      default_security {}
    }
    skip_server_verification {}
  }

  # Endpoint selection
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "LB_OVERRIDE"
}

# Advanced Origin Pool with additional configuration
resource "f5xc_origin_pool" "advanced" {
  name      = "advanced-origin-pool"
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

  # Multiple origin servers
  origin_servers {
    public_name {
      dns_name         = "origin1.example.com"
      refresh_interval = 30
    }
  }

  origin_servers {
    public_name {
      dns_name         = "origin2.example.com"
      refresh_interval = 30
    }
  }

  origin_servers {
    k8s_service {
      service_name = "backend-svc"
      site_locator {
        site {
          name      = "my-site"
          namespace = "system"
        }
      }
      vk8s_networks {}
    }
  }

  port = 443

  # TLS with custom certificate
  use_tls {
    sni = "backend.example.com"
    tls_config {
      custom_security {
        cipher_suites = ["TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"]
        min_version   = "TLS12"
        max_version   = "TLS13"
      }
    }
    volterra_trusted_ca {}
  }

  # Health check
  healthcheck {
    name      = "my-healthcheck"
    namespace = "system"
  }

  # Advanced load balancing
  endpoint_selection     = "LOCAL_PREFERRED"
  loadbalancer_algorithm = "ROUND_ROBIN"

  # Automatic origin server subsets
  origin_servers_subset_rule_list {
    origin_server_subset_rules {
      keys = ["version"]
      any_asn {}
    }
  }
}
