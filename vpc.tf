data "alicloud_zones" "default" {
}

resource "alicloud_vpc" "vpc" {
  vpc_name   = "terraform-vpc"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id     = alicloud_vpc.vpc.id
  vswitch_name = "terraform-vswitch"
  cidr_block = "172.16.0.0/21"
  zone_id    = data.alicloud_zones.default.zones[0].id
  depends_on = [alicloud_vpc.vpc]
}