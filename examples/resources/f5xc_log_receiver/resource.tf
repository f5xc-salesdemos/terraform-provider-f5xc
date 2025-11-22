# Log Receiver Resource Example
# Creates a new Log Receiver object

# Basic Log Receiver configuration
resource "f5xc_log_receiver" "example" {
  name      = "my-log-receiver"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Log Receiver configuration
  # HTTP receiver example
  http_receiver {
    uri = "https://logs.example.com/ingest"
    batch {
      max_bytes   = 1048576
      max_events  = 100
      timeout_seconds = 5
    }
    no_tls_verify_hostname {}
    no_compression {}
  }
}
