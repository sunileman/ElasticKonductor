resource "random_string" "lbname" {
  length  = 16
  special = false
  upper   = false
  numeric = false
}

resource "random_string" "lb2name" {
  length  = 16
  special = false
  upper   = false
  numeric = false
}
