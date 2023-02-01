resource "kubectl_manifest" "enterprise_trial_license" {
    yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  name: eck-trial-license
  namespace: elastic-system
  labels:
    license.k8s.elastic.co/type: enterprise_trial
  annotations:
    elastic.co/eula: accepted
YAML
}
