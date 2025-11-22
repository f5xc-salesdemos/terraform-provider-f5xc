# Route Data Source Example
# Retrieves information about an existing Route

# Look up an existing Route by name
data "f5xc_route" "example" {
  name      = "my-route"
  namespace = "system"
}

# Example: Use the data source in another resource
# output "route_id" {
#   value = data.f5xc_route.example.id
# }
