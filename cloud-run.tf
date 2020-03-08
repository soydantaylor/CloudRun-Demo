resource "google_cloud_run_service" "statusupdater" {
  name     = "statusupdater"
  location = var.region

  template {
    spec {
      containers {
        image = "jjIMAGEjj"
        env {
          name = "SOURCE"
          value = "remote"
        }
        env {
          name = "TARGET"
          value = "home"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}
