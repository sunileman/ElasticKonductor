resource "random_string" "lbname" {
  length  = 16
  special = false
  upper   = false
  numeric = false
}

resource "random_string" "ingestLbName" {
  length  = 16
  special = false
  upper   = false
  numeric = false
}

resource "random_string" "searchLbName" {
  length  = 16
  special = false
  upper   = false
  numeric = false
}
