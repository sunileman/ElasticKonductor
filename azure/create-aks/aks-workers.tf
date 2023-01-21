resource "azurerm_kubernetes_cluster_node_pool" "master" {
  name                  = "master"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.master_instance_type
  node_count            = var.master_instance_count

  tags = {
    Environment = "1ClickECK"
  }

  node_labels = {
    "nodetype" = "master"
  }
}


resource "azurerm_kubernetes_cluster_node_pool" "kibana" {
  name                  = "kibana"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.kibana_instance_type
  node_count            = var.kibana_instance_count

  tags = {
    Environment = "1ClickECK"
  }

  node_labels = {
    "nodetype" = "kibana"
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "hot" {
  name                  = "hot"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.hot_instance_type
  node_count            = var.hot_instance_count

  tags = {
    Environment = "1ClickECK"
  }

  node_labels = {
    "nodetype" = "hot"
  }

}


resource "azurerm_kubernetes_cluster_node_pool" "warm" {
  name                  = "warm"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.warm_instance_type
  node_count            = var.warm_instance_count

  tags = {
    Environment = "1ClickECK"
  }

  node_labels = {
    "nodetype" = "warm"
  }

}


resource "azurerm_kubernetes_cluster_node_pool" "cold" {
  name                  = "cold"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.cold_instance_type
  node_count            = var.cold_instance_count

  tags = {
    Environment = "1ClickECK"
  }

  node_labels = {
    "nodetype" = "cold"
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "frozen" {
  name                  = "frozen"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.frozen_instance_type
  node_count            = var.frozen_instance_count

  tags = {
    Environment = "1ClickECK"
  }

  node_labels = {
    "nodetype" = "frozen"
  }

}


resource "azurerm_kubernetes_cluster_node_pool" "ml" {
  name                  = "ml"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.ml_instance_type
  node_count            = var.ml_instance_count

  tags = {
    Environment = "1ClickECK"
  }

  node_labels = {
    "nodetype" = "ml"
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "util" {
  name                  = "util"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size               = var.util_instance_type
  node_count            = var.util_instance_count

  tags = {
    Environment = "1ClickECK"
  }

  node_labels = {
    "nodetype" = "util"
  }

}
