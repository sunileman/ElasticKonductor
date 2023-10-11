locals {
  project = "${var.automation_name}-${var.tags["project"]}"
  current_datetime = timestamp()
}