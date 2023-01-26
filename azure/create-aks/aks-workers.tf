resource "azurerm_kubernetes_cluster_node_pool" "master" {
  name                  = "master"
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

