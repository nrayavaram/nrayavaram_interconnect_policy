
provider "google" {
 access_token = var.access_token
 project = "airline1-sabre-wolverine"
}





resource "google_compute_interconnect_attachment" "on_prem" {
  name                     = "on-dev-appid-syst-bkonprem-icvlan"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "PARTNER"
  region                   = "us-west1"
  router                   = google_compute_router.foobar.id
  mtu                      = 1500
}


resource "google_compute_network" "foobar" {
  name                    = "on-dev-appid-syst-bkonprem-network"
  auto_create_subnetworks = false
  delete_default_routes_on_create = true
  mtu                     = 1500
}

resource "google_compute_router" "foobar" {
  name    = "on-dev-appid-syst-bkonprem-router"
  region  = "us-central1"
  network = "google_compute_network.foobar.name"
  bgp {
    # Google autonomous system number (ASN)
    asn = 16550
  }
}


resource "google_compute_interconnect_attachment" "foobar" {
  name    = "on-dev-appid-syst-bkonprem-icvlan"
  # Obs: router and attachment must reside in same region
  region  = "us-central1"
  type    = "DEDICATED"
  router  = google_compute_router.foobar.id
  mtu     = 1500
}
