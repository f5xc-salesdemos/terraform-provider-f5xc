# Proxy Data Source Example
# Retrieves information about an existing Proxy

# Look up an existing Proxy by name
data "f5xc_proxy" "example" {
  name      = "my-proxy"
  namespace = "system"
}

# Example: Use the data source in another resource
# output "proxy_id" {
#   value = data.f5xc_proxy.example.id
# }
