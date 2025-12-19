# INSECURE - Workshop demonstration only

variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "workshop-project-12345"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "europe-west1-b"
}

variable "machine_type" {
  description = "Machine type for compute instances"
  type        = string
  default     = "e2-medium"
}

# VULN-7: Hardcoded password
variable "db_password" {
  description = "Database root password"
  type        = string
  default     = "admin123" # INSECURE
  sensitive   = false      # INSECURE
}

# VULN-8: Hardcoded API key
variable "api_key" {
  description = "API Key for external service"
  type        = string
  default     = "AIzaSyDXxxxxxxxxxxxxxxxxxxxxxxxxxx" # INSECURE
  sensitive   = false                                # INSECURE
}
