#bucket to store website 
resource"google_storage_bucket" "website"{
    provider = google
    name ="website-by-dj"
    location="US"
}
#make the object acess control
resource "google_storage_object_access_control" "public_rule" {
   object = google_storage_bucket_object.static_site.name
   bucket = google_storage_bucket.website.name
   role="READER"
   entity = "allUsers"
}
#upload index.hml to bucket
resource "google_storage_bucket_object" "static_site"{
name="index.html"
source = "../website/index.html"
bucket = google_storage_bucket.website.name
}
resource "google_compute_global_address" "website_ip" {
    name = "website-dj-ip"
  
}
data "google_dns_managed_zone" "dns_zone_dj" {
  provider = google
  name="frist-one-gcp"
}
resource "google_dns_record_set" "website" {
  name = "website.${data.google_dns_managed_zone.dns_zone_dj.dns_name}"
  type = "A"
  ttl = 300
  managed_zone = data.google_dns_managed_zone.dns_zone_dj.name
  rrdatas = [google_compute_global_address.website_ip.address]
}
#adding the bucket as a  cdn backend
resource "google_compute_backend_bucket" "website-backend" {
    name = "website-bucket"
    bucket_name = google_storage_bucket.website.name
      description="contains the files needded for websote"
      enable_cdn = true
}

#gcp url map
resource "google_compute_url_map" "website" {
    name="website-url-map"
    default_service = google_compute_backend_bucket.website-backend.self_link
    host_rule {
      hosts = ["*"]
      path_matcher = "allpaths"
    }
    path_matcher {
      name ="allpaths"
      default_service = google_compute_backend_bucket.website-backend.self_link
    }
    }
resource "google_compute_target_http_proxy" "website"{
    name = "website-target-proxy"
    url_map = google_compute_url_map.website.self_link
  
}
#gcp forwarding  rule
resource "google_compute_global_forwarding_rule" "default" {
  name = "website-forwarding-rule"
  load_balancing_scheme = "EXTERNAL"
  ip_address = google_compute_global_address.website_ip.address
  ip_protocol = "TCP"
  port_range = "80"
  target = google_compute_target_http_proxy.website.self_link
  }
