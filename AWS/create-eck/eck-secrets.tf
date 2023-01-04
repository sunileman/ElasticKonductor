resource "kubernetes_manifest" "createEckSecrets" {
  manifest = {
    "apiVersion" = "v1"
    "data" = {
      "aws-key" =  var.aws_access_key
      "aws-secret" = var.aws_secret_key
    }
    "kind" = "Secret"
    "metadata" = {
      "name" = "my-secret",
      "namespace" = "default"
    }
    "type" = "Opaque"
  }
}
