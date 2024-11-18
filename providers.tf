terraform {
  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.70.3"
    }
  }
}

provider "huaweicloud" {
  region     = var.region
  access_key = var.hwc_access_key
  secret_key = var.hwc_secret_key
  alias      = "root_account"
}

provider "huaweicloud" {
  region     = var.region
  access_key = var.hwc_access_key
  secret_key = var.hwc_secret_key
  alias      = "member_account"
  assume_role {
    # only possible if IAM User has `Agent Operator` permission
    domain_name = var.member_account_name
    agency_name = var.member_account_agency_name
  }
}
