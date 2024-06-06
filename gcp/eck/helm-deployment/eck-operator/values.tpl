# values.tpl
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
      - matchExpressions:
        - key: "nodetype"
          operator: "In"
          values:
          - "${nodetype}"
