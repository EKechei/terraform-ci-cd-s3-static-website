variable "github_token" {
  description = "GitHub Token for authentication"
  type        = string
  sensitive   = true  # Mark sensitive variables as true to hide their values in logs and outputs
}

# Define other variables as needed
