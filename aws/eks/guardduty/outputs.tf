output "vpcid" {
  value = data.terraform_remote_state.k8s.outputs.eks-vpc_id
}