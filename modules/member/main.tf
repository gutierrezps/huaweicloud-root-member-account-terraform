resource "huaweicloud_vpc" "main" {
  name   = "vpc-member"
  cidr   = "192.168.0.0/16"
  region = "sa-brazil-1"
}

resource "huaweicloud_vpc_subnet" "main" {
  name              = "subnet-member"
  cidr              = "192.168.0.0/24"
  gateway_ip        = "192.168.0.1"
  vpc_id            = huaweicloud_vpc.main.id
  availability_zone = "sa-brazil-1b"
}

data "huaweicloud_account" "this" {}

locals {
  subnet_urn = join(":", [
    "vpc",
    huaweicloud_vpc_subnet.main.region,
    data.huaweicloud_account.this.id,
    "subnet",
    huaweicloud_vpc_subnet.main.id
  ])
}

resource "huaweicloud_ram_resource_share" "subnet_member" {
  name          = "subnet-member-share"
  resource_urns = [local.subnet_urn]
  principals    = var.share_account_ids
}
