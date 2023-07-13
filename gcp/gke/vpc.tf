resource "google_compute_network" "main" {
  name                            = lower(replace("${random_pet.name.id}-vpc", "-", ""))
  routing_mode                    = "REGIONAL"
  auto_create_subnetworks         = false
  mtu                             = 1460
  delete_default_routes_on_create = false

}

resource "google_compute_subnetwork" "private" {
  name                     = lower(replace("${random_pet.name.id}-private", "-", ""))
  #ip_cidr_range            = "10.0.0.0/18"
  ip_cidr_range            = var.gke_subnetwork_cidr
  region                   = var.region
  network                  = google_compute_network.main.id
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = var.gke_pod_range_cidr
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = var.gke_service_range_cidr
  }
}

resource "google_compute_router" "router" {
  name    = lower(replace("${random_pet.name.id}-router", "-", ""))
  region  = var.region
  network = google_compute_network.main.id
}

resource "google_compute_router_nat" "nat" {
  name   = lower(replace("${random_pet.name.id}-nat", "-", ""))
  router = google_compute_router.router.name
  region = var.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  nat_ip_allocate_option             = "MANUAL_ONLY"

  subnetwork {
    name                    = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ips = [google_compute_address.nat.self_link]
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address
resource "google_compute_address" "nat" {
  name         = lower(replace("${random_pet.name.id}-nat", "-", ""))
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

}

resource "google_compute_firewall" "allow-ssh" {
  name    = lower(replace("${random_pet.name.id}-vpc", "-", ""))
  network = google_compute_network.main.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}


