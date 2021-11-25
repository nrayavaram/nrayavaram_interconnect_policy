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


