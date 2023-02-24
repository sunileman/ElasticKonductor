resource "null_resource" "deploy-operator" {

  provisioner "local-exec" {
      command = "kubectl apply -f ./eck-yamls/operator.yaml" 
  }
}
