resource "google_compute_interconnect_attachment" "on_prem" {
  name                     = "on-prem-attachment"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "PARTNER"
  region                   = "us-west1"
  router                   = google_compute_router.foobar.id
  mtu                      = 1500
}

#resource "google_compute_router" "foobar" {
#  name    = "router"
#  network = google_compute_network.foobar.name
#  bgp {
#    asn = 16550
#  }
#}

#resource "google_compute_address" "address" {
#  name          = "test-address"
#  address_type  = "INTERNAL"
#  purpose       = "IPSEC_INTERCONNECT"
#  address       = "192.168.1.0"
#  prefix_length = 29
#  network       = google_compute_network.foobar.self_link
#}

resource "google_compute_network" "foobar" {
  name                    = "network"
  auto_create_subnetworks = false
  mtu                     = 1500
  project                 = var.project_id
}

resource "google_compute_router" "foobar" {
  name    = "my-router"
  network = google_compute_network.foobar.name
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
    advertised_ip_ranges {
      range = "1.2.3.4"
    }
    advertised_ip_ranges {
      range = "6.7.0.0/16"
    }
  }
}
