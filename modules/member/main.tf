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
