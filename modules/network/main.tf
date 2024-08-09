# resource "openstack_networking_network_v2" "network" {
#   name = var.network_name
# }

# resource "openstack_networking_subnet_v2" "subnet" {
#   name            = var.subnet_name
#   network_id      = openstack_networking_network_v2.network.id
#   cidr            = var.cidr
#   ip_version      = 4
#   gateway_ip      = var.gateway_ip
#   dns_nameservers = var.dns_nameservers
# }

output "network_id" {
  value = var.external_network_id
}
