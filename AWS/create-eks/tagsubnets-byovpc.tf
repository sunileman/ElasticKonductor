resource "aws_ec2_tag" "tagPubSubnet" {
  for_each    = toset(data.aws_subnets.public.ids)
  resource_id = each.value
  key         = "test"
  value       = "1"
}
