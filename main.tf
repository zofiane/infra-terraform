terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
    }
  }
}

provider "openstack" {
  auth_url         = var.os_auth_url
  tenant_id        = var.os_project_id
  tenant_name      = var.os_project_name
  user_domain_name = var.os_user_domain_name
  project_domain_id= var.os_project_domain_id
  user_name        = var.os_username
  password         = var.os_password
  region           = var.os_region_name
  endpoint_type    = var.os_interface
}

module "network" {
  source = "./modules/network"
  external_network_id = var.external_network_id
}

module "security_group" {
  source = "./modules/security_group"
}

module "volume" {
  source      = "./modules/volume"
  instance_name = "jenkins"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}


module "instance" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  network_id        = module.network.network_id
  instance_name     = "jenkins"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume.volume_id
}



module "volume_sonarqube" {
  source      = "./modules/volume"
  instance_name = "SonarQube"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}
module "SonarQube" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  network_id        = module.network.network_id
  instance_name     = "SonarQube"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_sonarqube.volume_id
  
}

module "volume_nexus" {
  source      = "./modules/volume"
  instance_name = "nexus"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}
module "nexus" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor_id
  key_pair          = var.key_pair
  network_id        = module.network.network_id
  instance_name     = "nexus"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_nexus.volume_id
  
}


module "volume_Master_k8s" {
  source      = "./modules/volume"
  instance_name = "Master_k8s"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}
module "Master_k8s" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor2_id
  key_pair          = var.key_pair
  network_id        = module.network.network_id
  instance_name     = "Master_k8s"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_Master_k8s.volume_id
  
}

module "volume_Worker_1" {
  source      = "./modules/volume"
  instance_name = "Worker_1"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}
module "Worker_1" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor2_id
  key_pair          = var.key_pair
  network_id        = module.network.network_id
  instance_name     = "Worker_1"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_Worker_1.volume_id
  
}

module "volume_Worker_2" {
  source      = "./modules/volume"
  instance_name = "Worker_2"
  image_id      = var.image_id
  volume_size   = var.volume_size
  region        = var.os_region_name
}
module "Worker_2" {
  source = "./modules/instance"
  image_id          = var.image_id
  flavor_id         = var.flavor2_id
  key_pair          = var.key_pair
  network_id        = module.network.network_id
  instance_name     = "Worker_2"
  security_group_ids= [module.security_group.security_group_id]
  volume_id        = module.volume_Worker_2.volume_id
  
}


