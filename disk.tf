resource "alicloud_ecs_disk" "ecs_disk" {
  zone_id           = alicloud_instance.ecs_instance.availability_zone
  size              = "20"
  tags = {
    Name = "TerraformTest-disk"
  }
}

resource "alicloud_ecs_disk_attachment" "ecs_disk_att" {
  disk_id     = alicloud_ecs_disk.ecs_disk.id
  instance_id = alicloud_instance.ecs_instance.id
}