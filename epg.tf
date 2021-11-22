### Point to NetOps remote backend to get info about Tenant, VRF,etc

data "terraform_remote_state" "networking" {
  backend = "remote"
  config = {
    organization = "cisco-dcn-ecosystem"
    workspaces = {
      name = "camrossi-netops"
    }
  }
}

resource "aci_application_profile" "app" {
  tenant_dn = data.terraform_remote_state.networking.outputs.tenant_id
  name      = var.app
}

resource "aci_application_epg" "epgs" {
  count = length(var.epgs)
  name  = var.epgs[count.index]
  application_profile_dn = aci_application_profile.app.id
  
}