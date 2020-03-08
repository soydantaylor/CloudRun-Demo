provider "google" {
  credentials = file("key.json")
  project     = var.project-name
  region      = var.region
}

data "terraform_remote_state" "myBackend" {
   backend = "gcs"
   config = {
     bucket = var.terraform-bucket
     prefix = "CloudRun-Demo/dev/"
   }
}

