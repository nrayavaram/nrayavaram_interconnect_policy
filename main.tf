provider "google" {
 access_token = var.access_token
 project = "airline1-sabre-wolverine"
}



resource "google_compute_interconnect_attachment" "on_prem" {
  name                     = "on-dev-appid-syst-bkonprem-icvlan"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "PARTNER"
  router                   = google_compute_router.foobar.id
  mtu                      = 1500
}

resource "google_compute_router" "foobar" {
  name    = "on-dev-appid-syst-bkonprem-router"
  network = google_compute_network.foobar.name
  bgp {
    asn = 16550
  }
}

resource "google_compute_network" "foobar" {
  name                    = "on-dev-appid-syst-bkonprem-network"
  auto_create_subnetworks = false
}

resource "google_compute_interconnect_attachment" "ipsec-encrypted-interconnect-attachment" {
  name                     = "on-dev-appid-syst-bkonprem-attachment"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "PARTNER"
  router                   = google_compute_router.router.id
  encryption               = "IPSEC"
  ipsec_internal_addresses = [
    google_compute_address.address.self_link,
  ]
}

resource "google_compute_address" "address" {
  name          = "on-dev-appid-syst-bktest-address"
  address_type  = "INTERNAL"
  purpose       = "IPSEC_INTERCONNECT"
  address       = "192.168.1.0"
  prefix_length = 29
  network       = google_compute_network.network.self_link
}

resource "google_compute_router" "router" {
  name                          = "on-dev-appid-syst-bktest-router"
  network                       = google_compute_network.network.name
  encrypted_interconnect_router = true
  bgp {
    asn = 16550
  }
}

resource "google_compute_network" "network" {
  name                    = "on-dev-appid-syst-bktest-network"
  auto_create_subnetworks = false
}

