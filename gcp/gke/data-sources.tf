data "google_container_engine_versions" "zone" {
  provider       = google-beta
  location       =  var.region
  version_prefix = var.gke_version
  project = var.gcp_project
}

