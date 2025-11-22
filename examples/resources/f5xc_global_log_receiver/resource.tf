# Global Log Receiver Resource Example
# Creates a new Global Log Receiver object

# Basic Global Log Receiver configuration
resource "f5xc_global_log_receiver" "example" {
  name      = "my-global-log-receiver"
  namespace = "system"

  labels = {
    environment = "production"
    managed_by  = "terraform"
  }

  annotations = {
    "owner" = "platform-team"
  }

  # Resource-specific configuration
    # Empty. This can be used for messages where no values are ...
    audit_logs {
      # Configure audit_logs settings
    }
    # AWS Cloudwatch Logs Configuration. AWS Cloudwatch Logs Co...
    aws_cloud_watch_receiver {
      # Configure aws_cloud_watch_receiver settings
    }
    # Object reference. This type establishes a direct referenc...
    aws_cred {
      # Configure aws_cred settings
    }
}
