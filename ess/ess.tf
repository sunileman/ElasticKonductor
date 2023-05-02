data "ec_stack" "latest" {
  version_regex = var.version_regex
  region        = var.region
}

resource "ec_deployment" "ess_cluster" {
  region                 = "us-east-1"
  version                = data.ec_stack.latest.version

  name = var.deployment_name

  #https://www.elastic.co/guide/en/cloud/current/ec-regions-templates-instances.html
  deployment_template_id = var.deployment_template_id

  elasticsearch = {

    autoscale = var.autoscale_hot

    # If `autoscale` is set, all topology elements that
    # - either set `size` in the plan or
    # - have non-zero default `max_size` (that is read from the deployment templates's `autoscaling_max` value)
    # have to be listed even if their blocks don't specify other fields beside `id`


    hot = {
      size = var.autoscale_hot_ini_size

      autoscaling = {
        max_size          = var.autoscale_hot_max_size
        max_size_resource = var.autoscale_hot_max_size_resource
      }
    }

  }

  # Initial size for `hot_content` tier is set to 8g
  # so `hot_content`'s size has to be added to the `ignore_changes` meta-argument to ignore future modifications that can be made by the autoscaler
  lifecycle {
    ignore_changes = [
      elasticsearch.hot.size
    ]
  }

  kibana = {}

  integrations_server = {}

}