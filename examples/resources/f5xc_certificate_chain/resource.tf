# Certificate Chain Resource Example
# Shape of the Certificate Chain specification

# Basic Certificate Chain configuration
resource "f5xc_certificate_chain" "example" {
  name      = "my-certificate-chain"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
