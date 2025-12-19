# INSECURE - Workshop demonstration only
# Contains 6 intentional vulnerabilities

terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# VULN-1: Public bucket
resource "google_storage_bucket" "insecure_bucket" {
  name          = "${var.project_id}-insecure-bucket"
  location      = var.region
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.insecure_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers" # INSECURE: Public access
}

# VULN-2: SSH open to internet
resource "google_compute_firewall" "allow_all_ssh" {
  name    = "allow-all-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"] # INSECURE: Open to internet
}

# VULN-3: Shielded VM disabled
resource "google_compute_instance" "insecure_instance" {
  name         = "insecure-vm-instance"
  machine_type = var.machine_type
  zone         = var.zone

  shielded_instance_config {
    enable_secure_boot          = false # INSECURE
    enable_vtpm                 = false # INSECURE
    enable_integrity_monitoring = false # INSECURE
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  service_account {
    email  = google_service_account.insecure_sa.email
    scopes = ["cloud-platform"]
  }
}

# VULN-4: Over-permissive IAM
resource "google_service_account" "insecure_sa" {
  account_id   = "insecure-service-account"
  display_name = "Insecure Service Account"
}

resource "google_project_iam_member" "insecure_sa_editor" {
  project = var.project_id
  role    = "roles/editor" # INSECURE: Too permissive
  member  = "serviceAccount:${google_service_account.insecure_sa.email}"
}

# VULN-5 & VULN-6: Database security
resource "google_sql_database_instance" "insecure_db" {
  name             = "insecure-mysql-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"

    backup_configuration {
      enabled = false # INSECURE: No backups
    }

    ip_configuration {
      ipv4_enabled = true                              # INSECURE: Public IP
      ssl_mode     = "ALLOW_UNENCRYPTED_AND_ENCRYPTED" # INSECURE: Unencrypted connections allowed
    }
  }

  deletion_protection = false
}

resource "google_sql_user" "insecure_db_user" {
  name     = "root"
  instance = google_sql_database_instance.insecure_db.name
  password = var.db_password # INSECURE: Hardcoded password
}
