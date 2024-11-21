module "root" {
  source              = "./modules/root"
  member_account_name = var.member_account_name
  providers = {
    huaweicloud = huaweicloud.root_account
  }
}

module "member" {
  source            = "./modules/member"
  share_account_ids = [module.root.account_id]
  providers = {
    huaweicloud = huaweicloud.member_account
  }
}
