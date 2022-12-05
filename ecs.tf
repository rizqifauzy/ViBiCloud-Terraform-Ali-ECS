data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones[0].id
}

data "alicloud_images" "default" {
  name_regex  = "^ubuntu_20.*64"
  most_recent = true
  owners      = "system"
}

resource "alicloud_instance" "ecs_instance" {
  image_id          = data.alicloud_images.default.images[0].id
  instance_type     = data.alicloud_instance_types.default.instance_types[0].id
  availability_zone = data.alicloud_zones.default.zones[0].id
  security_groups   = [alicloud_security_group.group.id]
  vswitch_id        = alicloud_vswitch.vsw.id
  instance_name     = "TerraformTest-instance"
  key_name          = alicloud_ecs_key_pair.publickey.id

  tags = {
    Name = "TerraformTest-instance"
  }
}

resource "alicloud_eip_address" "eip" {
  address_name         = "tf-testAcc1234"
  isp                  = "BGP"
  #internet_charge_type = "PayByDataTransfer"
  payment_type         = "PayAsYouGo"
}

resource "alicloud_eip_association" "eip_asso" {
  allocation_id = alicloud_eip_address.eip.id
  instance_id   = alicloud_instance.ecs_instance.id
}

