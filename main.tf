provider "google" {
  project = "iaas-provision-236417"
  region = "asia-south1"
  zone = "asia-south1-c"
}

resource "google_compute_instance" "vm_instance" {
  count = 4
  name = "terraform-instance-${count.index}"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
      size = "30"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "default"
    access_config = {
    }
  }
  metadata {
  sshKeys = "reddisekhara_n:/home/reddisekhara_n/.ssh/id_rsa.pub"
  }
}

resource "google_compute_firewall" "http" {
  name    = "default-firewall-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["default-firewall-http"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "https" {
  name    = "default-firewall-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}
