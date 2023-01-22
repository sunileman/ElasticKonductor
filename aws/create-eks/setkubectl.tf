resource "null_resource" "setkubectl" {

 triggers = {
    value = aws_eks_cluster.OneClick.status
 }
 provisioner "local-exec" {
    #command = "aws eks --region ${var.region} update-kubeconfig --name ${local.project}"
    command = "aws eks --region ${var.region} update-kubeconfig --name ${random_pet.name.id}"
  }
depends_on = [aws_eks_cluster.OneClick]
}
