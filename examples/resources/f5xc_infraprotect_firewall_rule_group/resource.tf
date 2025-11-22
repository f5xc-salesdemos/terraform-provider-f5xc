# Infraprotect Firewall Rule Group Resource Example
# Amends a DDoS transit Firewall Rule Group

# Basic Infraprotect Firewall Rule Group configuration
resource "f5xc_infraprotect_firewall_rule_group" "example" {
  name      = "my-infraprotect-firewall-rule-group"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }
}
