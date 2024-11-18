variable "hwc_access_key" {
  type        = string
  description = "Access Key (AK) of IAM User in the root account"
}

variable "hwc_secret_key" {
  type        = string
  sensitive   = true
  description = "Secret Access Key (SK) of IAM User in the root account"
}

variable "region" {
  type        = string
  description = "Region where cloud resources will be deployed by default"
}

variable "member_account_name" {
  type        = string
  description = "Account Name of member account of Organization"
}

variable "member_account_agency_name" {
  type        = string
  default     = "OrganizationAccountAccessAgency"
  description = "Agency name on member account which grants admin permissions to Organization root account"
}
