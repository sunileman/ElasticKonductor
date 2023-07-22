variable "version_regex" {
  description = "The version regex to use"
  type        = string
  default     = "latest"
}

variable "region" {
  description = "Cloud region to use"
  type        = string
  default     = "us-east-1"
}

variable "deployment_name" {
  description = "The name of the deployment"
  type        = string
  default     = "my-ess-deployment"
}

variable "deployment_template_id" {
  description = "The ID of the deployment template"
  type        = string
  default     = "aws-io-optimized-v2"
}

variable "autoscale_hot" {
  description = "Autoscaling hot setting"
  type        = string
  default     = "false"
}

variable "autoscale_hot_ini_size" {
  description = "Initial size for autoscaling hot"
  type        = string
  default     = "8g"
}

variable "autoscale_hot_max_size" {
  description = "Maximum size for autoscaling hot"
  type        = string
  default     = "128g"
}

variable "autoscale_hot_max_size_resource" {
  description = "Resource type for autoscaling hot max size"
  type        = string
  default     = "memory"
}
