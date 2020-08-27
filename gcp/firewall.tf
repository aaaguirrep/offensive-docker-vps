resource "google_compute_firewall" "traffic-ingress" {
  name    = "traffic-ingress"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22","8080","80","443","3128"]
  }

  source_ranges = ["0.0.0.0/0"]
}