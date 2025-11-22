# Address Allocator Resource Example
# Create Address Allocator will create an address allocator object in 'system' namespace of the user

# Basic Address Allocator configuration
resource "f5xc_address_allocator" "example" {
  name      = "my-address-allocator"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Address Allocation Scheme. Decides the scheme to be used ...
    address_allocation_scheme {
      # Configure address_allocation_scheme settings
    }
}
