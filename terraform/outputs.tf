output "bucket_name" {
  description = "Name of the storage bucket"
  value       = google_storage_bucket.insecure_bucket.name
}

output "bucket_url" {
  description = "URL of the storage bucket"
  value       = google_storage_bucket.insecure_bucket.url
}

output "instance_name" {
  description = "Name of the compute instance"
  value       = google_compute_instance.insecure_instance.name
}

output "database_name" {
  description = "Name of the database instance"
  value       = google_sql_database_instance.insecure_db.name
}

output "database_public_ip" {
  description = "Public IP of the database instance"
  value       = google_sql_database_instance.insecure_db.public_ip_address
}

output "service_account_email" {
  description = "Email of the service account"
  value       = google_service_account.insecure_sa.email
}
