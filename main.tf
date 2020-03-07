provider "google" {
  credentials = file("key.json")
  project     = var.project-name
  region      = var.region
}