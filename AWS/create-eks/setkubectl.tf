resource "null_resource" "setkubectl" {

 triggers = {
    value = aws_eks_cluster.OneClick.status
 }
 provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${local.project}"
  }
depends_on = [aws_eks_cluster.OneClick]
}
