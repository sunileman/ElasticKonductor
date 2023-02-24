# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "kubernetes" {
  account_id = lower(replace("${random_pet.name.id}", var.automation_name, "oce"))
}
