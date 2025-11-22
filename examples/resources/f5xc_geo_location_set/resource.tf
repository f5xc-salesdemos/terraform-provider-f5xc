# Geo Location Set Resource Example
# Creates a Geolocation Set

# Basic Geo Location Set configuration
resource "f5xc_geo_location_set" "example" {
  name      = "my-geo-location-set"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Geo Location Set configuration
  country_codes = ["US", "CA", "GB"]
}
