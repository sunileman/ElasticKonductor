spec:
  deployment:
    replicas: 1
    podTemplate:
      spec:
        serviceAccountName: fleet-server
        automountServiceAccountToken: true
        securityContext:
          runAsUser: 0
        containers:
        - name: agent
          resources:
            requests:
              memory: ${fleet_pod_memory}
              cpu: ${fleet_pod_cpu}
        affinity:
          nodeAffinity:
            requiredDuringSchedulingIgnoredDuringExecution:
              nodeSelectorTerms:
              - matchExpressions:
                - key: nodetype
                  operator: In
                  values:
                  - fleet