# Dns Compliance Checks Resource Example
# Create DNS Compliance Checks Specification in a given namespace. If one already exists it will give an error.

# Basic Dns Compliance Checks configuration
resource "f5xc_dns_compliance_checks" "example" {
  name      = "my-dns-compliance-checks"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
