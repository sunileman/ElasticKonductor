resource "azurerm_kubernetes_cluster_node_pool" "master" {
  name                  = "master"
  count                 = var.master_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.master_instance_type
  #node_count            = var.master_instance_count

  enable_auto_scaling = false
  #min_count           = var.master_instance_count
  #max_count           = var.master_max_instance_count
  node_count           = var.master_instance_count

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.master_instance_k8s_label
  
}


resource "azurerm_kubernetes_cluster_node_pool" "kibana" {
  name                  = "kibana"
  count                 = var.kibana_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.kibana_instance_type
  #node_count            = var.kibana_instance_count
  
  enable_auto_scaling = true
  min_count           = var.kibana_instance_count
  max_count           = var.kibana_max_instance_count

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.kibana_instance_k8s_label 

}

resource "azurerm_kubernetes_cluster_node_pool" "hot" {
  name                  = "hot"
  count                 = var.hot_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.hot_instance_type
  #node_count            = var.hot_instance_count

  enable_auto_scaling = true
  min_count           = var.hot_instance_count
  max_count           = var.hot_max_instance_count

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.hot_instance_k8s_label
}


resource "azurerm_kubernetes_cluster_node_pool" "warm" {
  name                  = "warm"
  count                 = var.warm_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.warm_instance_type
  #node_count            = var.warm_instance_count


  enable_auto_scaling = true
  min_count           = var.warm_instance_count
  max_count           = var.warm_max_instance_count

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.warm_instance_k8s_label
}


resource "azurerm_kubernetes_cluster_node_pool" "cold" {
  name                  = "cold"
  count                 = var.cold_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.cold_instance_type
  #node_count            = var.cold_instance_count

  enable_auto_scaling = true
  min_count           = var.cold_instance_count
  max_count           = var.cold_max_instance_count

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.cold_instance_k8s_label
}

resource "azurerm_kubernetes_cluster_node_pool" "frozen" {
  name                  = "frozen"
  count                 = var.frozen_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.frozen_instance_type
  #node_count            = var.frozen_instance_count

  enable_auto_scaling = true
  min_count           = var.frozen_instance_count
  max_count           = var.frozen_max_instance_count

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.frozen_instance_k8s_label
}


resource "azurerm_kubernetes_cluster_node_pool" "ml" {
  name                  = "ml"
  count                 = var.ml_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.ml_instance_type
  #node_count            = var.ml_instance_count

  enable_auto_scaling = true
  min_count           = var.ml_instance_count
  max_count           = var.ml_max_instance_count


  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.ml_instance_k8s_label
}


resource "azurerm_kubernetes_cluster_node_pool" "logstash" {
  name                  = "logstash"
  count                 = var.logstash_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.logstash_instance_type
  #node_count            = var.logstash_instance_count

  enable_auto_scaling = true
  min_count           = var.logstash_instance_count
  max_count           = var.logstash_max_instance_count

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.logstash_instance_k8s_label
}

resource "azurerm_kubernetes_cluster_node_pool" "windws" {
  name                  = "windws"
  count                 = var.windows_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.windows_instance_type

  enable_auto_scaling = true
  min_count           = var.windows_instance_count
  max_count           = var.windows_max_instance_count

  os_type             = var.windows_os_type
  os_sku              = var.windows_os_sku
  os_disk_size_gb     = var.windows_os_disk_size_gb


  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.windows_instance_k8s_label
}


resource "azurerm_kubernetes_cluster_node_pool" "otel" {
  name                  = "otel"
  count                 = var.otel_instance_count >= 1 ? 1 : 0

  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.otel_instance_type
  node_count            = var.otel_instance_count

  enable_auto_scaling = false

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.otel_instance_k8s_label

}


resource "azurerm_kubernetes_cluster_node_pool" "entsearch" {
  name                  = "entsearch"
  count                 = var.entsearch_instance_count >= 1 ? 1 : 0
  
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.entsearch_instance_type
  #node_count            = var.entsearch_instance_count

  enable_auto_scaling = true
  min_count           = var.entsearch_instance_count
  max_count           = var.entsearch_max_instance_count

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  node_labels = var.entsearch_instance_k8s_label
}