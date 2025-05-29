resource "ovh_cloud_project_network_private" "network" {
  service_name = var.ovh_service_name # Public Cloud service name
  vlan_id     = 152
  name       = "terraform_small_cluster_private_net"
  regions    = ["GRA7"]
}

resource "ovh_cloud_project_network_private_subnet" "subnet" {
  service_name = var.ovh_service_name
  network_id   = ovh_cloud_project_network_private.network.id

  # whatever region, for test purpose
  region     = "GRA7"
  start      = "192.168.168.100"
  end        = "192.168.168.200"
  network    = "192.168.168.0/24"
  dhcp       = true
  no_gateway = false

  depends_on    = [ ovh_cloud_project_network_private.network ] 
}

resource "ovh_cloud_project_gateway" "gateway" {
  service_name = var.ovh_service_name
  name       = "gateway_small_cluster"
  model      = "s"
  region     = "GRA7"
  network_id = tolist(ovh_cloud_project_network_private.network.regions_attributes[*].openstackid)[0]
  subnet_id  = ovh_cloud_project_network_private_subnet.subnet.id

  depends_on    = [ ovh_cloud_project_network_private_subnet.subnet ] 
}

resource "ovh_cloud_project_kube" "my_cluster" {
  service_name  = var.ovh_service_name
  name          = "test-gra7-kube-attach_small_cluster"
  region        = "GRA7"

  private_network_id = tolist(ovh_cloud_project_network_private.network.regions_attributes[*].openstackid)[0]
  nodes_subnet_id = ovh_cloud_project_network_private_subnet.subnet.id

  depends_on    = [ ovh_cloud_project_gateway.gateway ] 

  timeouts {
    create = "1h"
    update = "1h"
    delete = "1h"
  }
}

resource "ovh_cloud_project_kube_nodepool" "node_pool_1" {
  service_name  = var.ovh_service_name
  kube_id       = ovh_cloud_project_kube.my_cluster.id
  name          = "my-pool-1"
  flavor_name   = "b3-8"
  desired_nodes = 3

  depends_on    = [ ovh_cloud_project_kube.my_cluster ] 
}