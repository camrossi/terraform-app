resource "aci_filter" "web2app" {
  tenant_dn = data.terraform_remote_state.networking.outputs.tenant_id
  name      = "web2app"
}

resource "aci_filter" "app2db" {
  tenant_dn = data.terraform_remote_state.networking.outputs.tenant_id
  name      = "app2db"
}


resource "aci_filter_entry" "web2app" {
  name        = "web2app"
  filter_dn   = aci_filter.web2app.id
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "7777"
  d_to_port   = "7777"
}
resource "aci_filter_entry" "app2db" {
  name        = "web2app"
  filter_dn   = aci_filter.app2db.id
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "6324"
  d_to_port   = "6324"
}

resource "aci_contract" "web2app" {
  tenant_dn = data.terraform_remote_state.networking.outputs.tenant_id
  name      = "web2app"
}

resource "aci_contract_subject" "web2app" {
  contract_dn                  = aci_contract.web2app.id
  name                         = "Subj"
  relation_vz_rs_subj_filt_att = aci_filter.web2app.id
}

resource "aci_contract" "app2db" {
  tenant_dn = data.terraform_remote_state.networking.outputs.tenant_id
  name      = "app2db"
}

resource "aci_contract_subject" "app2db" {
  contract_dn                  = aci_contract.app2db.id
  name                         = "Subj"
  relation_vz_rs_subj_filt_att = aci_filter.app2db.id
}

