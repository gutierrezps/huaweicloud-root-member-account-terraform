data "huaweicloud_identitycenter_instance" "main" {}

resource "huaweicloud_identitycenter_user" "demo" {
  identity_store_id = data.huaweicloud_identitycenter_instance.main.identity_store_id
  user_name         = "demo"
  password_mode     = "OTP"
  display_name      = "demo"
  family_name       = "demo"
  given_name        = "demo"
  email             = "demo@example.com"
}

resource "huaweicloud_identitycenter_permission_set" "demo" {
  instance_id      = data.huaweicloud_identitycenter_instance.main.id
  name             = "demo_permission"
  session_duration = "PT8H"
}

locals {
  demo_role_display_names = [
    "Tenant Administrator"
  ]

  demo_role_names = [
    # For "Security Administrator" role, the data block returns multiple results,
    # and therefore cannot be used with "display_name" parameter. In this case,
    # you need to use the data block with "name" parameter instead, and use
    # one of the names listed in the provider documentation:
    # https://registry.terraform.io/providers/huaweicloud/huaweicloud/latest/docs/data-sources/identity_role
    "secu_admin"
  ]
}

# Due to "Security Administrator" limitation described above, we need two
# distinct data blocks, one using "display_name" parameter (which accepts the
# same name displayed in the Console), and another data block using "name"
# parameter for ambiguous cases

data "huaweicloud_identity_role" "demo_roles_display_names" {
  for_each     = toset(local.demo_role_display_names)
  display_name = each.value
}

data "huaweicloud_identity_role" "demo_roles_names" {
  for_each = toset(local.demo_role_names)
  name     = each.value
}

resource "huaweicloud_identitycenter_system_policy_attachment" "demo" {
  instance_id       = data.huaweicloud_identitycenter_instance.main.id
  permission_set_id = huaweicloud_identitycenter_permission_set.demo.id
  policy_ids = concat(
    flatten([
      for role in data.huaweicloud_identity_role.demo_roles_names : [
        role.id
      ]
    ]),
    flatten([
      for role in data.huaweicloud_identity_role.demo_roles_display_names : [
        role.id
      ]
    ])
  )
}

resource "huaweicloud_identitycenter_group" "demo" {
  identity_store_id = data.huaweicloud_identitycenter_instance.main.identity_store_id
  name              = "demo_group"
}

resource "huaweicloud_identitycenter_group_membership" "demo" {
  identity_store_id = data.huaweicloud_identitycenter_instance.main.identity_store_id
  group_id          = huaweicloud_identitycenter_group.demo.id
  member_id         = huaweicloud_identitycenter_user.demo.id
}

data "huaweicloud_organizations_accounts" "member" {
  name = var.member_account_name
}

resource "huaweicloud_identitycenter_account_assignment" "demo_member" {
  instance_id       = data.huaweicloud_identitycenter_instance.main.id
  permission_set_id = huaweicloud_identitycenter_permission_set.demo.id
  principal_id      = huaweicloud_identitycenter_group.demo.id
  principal_type    = "GROUP"
  target_id         = data.huaweicloud_organizations_accounts.member.accounts[0].id
  target_type       = "ACCOUNT"
}
