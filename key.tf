resource "alicloud_ecs_key_pair" "publickey" {
  key_pair_name   = "my_public_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "alicloud_ecs_key_pair_attachment" "example" {
  key_pair_name     = alicloud_ecs_key_pair.publickey.id
  instance_ids = alicloud_instance.ecs_instance.*.id
}