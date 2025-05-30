resource "ovh_cloud_project_network_private" "network" {
    service_name = var.service_name # Public Cloud service name
    vlan_id      = var.vlan_id
    name         = "terraform_small_cluster_private_net"
    regions      = [var.region]
}

resource "ovh_cloud_project_network_private_subnet" "subnet" {
    service_name = var.service_name
    network_id   = ovh_cloud_project_network_private.network.id

    # whatever region, for test purpose
    region       = var.region
    start        = var.network_start
    end          = var.network_end
    network      = var.network
    dhcp         = true
    no_gateway   = false

    depends_on   = [ ovh_cloud_project_network_private.network ] 
}

resource "ovh_cloud_project_gateway" "gateway" {
    service_name = var.service_name
    name         = "gateway_small_cluster"
    model        = "s"
    region       = var.region
    network_id   = tolist(ovh_cloud_project_network_private.network.regions_attributes[*].openstackid)[0]
    subnet_id    = ovh_cloud_project_network_private_subnet.subnet.id

    depends_on   = [ ovh_cloud_project_network_private_subnet.subnet ] 
}

resource "ovh_cloud_project_kube" "my_cluster" {
    service_name = var.service_name
    name         = "test-gra7-kube-attach_small_cluster"
    region       = var.region

    private_network_id = tolist(ovh_cloud_project_network_private.network.regions_attributes[*].openstackid)[0]
    nodes_subnet_id = ovh_cloud_project_network_private_subnet.subnet.id

    depends_on   = [ ovh_cloud_project_gateway.gateway ] 

    timeouts {
        create = "1h"
        update = "1h"
        delete = "1h"
    }
}

resource "ovh_cloud_project_kube_nodepool" "node_pool_1" {
    service_name  = var.service_name
    kube_id       = ovh_cloud_project_kube.my_cluster.id
    name          = "my-pool-1"
    flavor_name   = "b3-8"
    desired_nodes = 3

    depends_on    = [ ovh_cloud_project_kube.my_cluster ] 
}