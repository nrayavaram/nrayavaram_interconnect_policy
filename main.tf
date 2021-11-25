provider "google" {
 access_token = var.access_token
 project = "airline1-sabre-wolverine"
}



resource "google_compute_interconnect_attachment" "on_prem" {
  name                     = "on-dev-appid-sys-bkonprem-icvlan"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "PARTNER"
  router                   = google_compute_router.foobar.id
  mtu                      = 1460
}

resource "google_compute_router" "foobar" {
  name    = "on-dev-appid-sys-bkonprem-router"
  network = google_compute_network.foobar.name
  bgp {
    asn = 16550
  }
}


resource "google_compute_router" "router" {
  name                          = "on-dev-appid-sys-test-router"
  network                       = google_compute_network.network.name
  encrypted_interconnect_router = true
  bgp {
    asn = 16550
  }
}
