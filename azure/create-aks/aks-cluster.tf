resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.name.id
}

resource "azurerm_kubernetes_cluster" "k8s" {
  location            = azurerm_resource_group.rg.location
  name                = random_pet.name.id
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.dns_prefix

  tags = merge(
    var.tags,
    {env=random_pet.name.id}
  )

  http_application_routing_enabled = true 

  kubernetes_version = var.aks_version

  default_node_pool {
    name       = "util"
    vm_size    = var.util_instance_type
    node_count = var.util_instance_count
    node_labels = var.util_instance_k8s_label
  }

  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }
}
