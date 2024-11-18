module "root" {
  source              = "./modules/root"
  member_account_name = var.member_account_name
  providers = {
    huaweicloud = huaweicloud.root_account
  }
}

module "member" {
  source = "./modules/member"
  providers = {
    huaweicloud = huaweicloud.member_account
  }
}
