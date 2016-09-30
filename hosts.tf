resource "aws_instance" "ucp-manager" {
  connection {
    user = "${var.ec2_user}"
    key_file = "${var.key_path}"
  }
  ami = "${lookup(var.ubuntu_amis, var.region)}"
  instance_type = "${var.manager_type}"
  #iam_instance_profile = "${aws_iam_instance_profile.default.id}"
  iam_instance_profile = "hromis-default"
  count = "${var.manager_count}"
  key_name = "${var.key_name}"
  user_data = "${file("./files/userdata.sh")}"
  vpc_security_group_ids = [
    "${aws_security_group.ucp.id}",
  ]
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  tags = {
    Name = "${var.env_name}-ucp-manager${count.index}"
    role = "ucp-manager"
    environment = "${var.env_name}"
  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "/dev/sdb"
    snapshot_id           = ""
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }
}

output "ucp-manager-ip" {
    value = "${join(",", aws_instance.ucp-manager.*.public_ip)}"
}

resource "aws_instance" "ucp-worker" {
  connection {
    user = "${var.ec2_user}"
    key_file = "${var.key_path}"
  }
  ami = "${lookup(var.ubuntu_amis, var.region)}"
  instance_type = "${var.worker_type}"
  #iam_instance_profile = "${aws_iam_instance_profile.default.id}"
  iam_instance_profile = "hromis-default"
  count = "${var.worker_count}"
  key_name = "${var.key_name}"
  user_data = "${file("./files/userdata.sh")}"
  vpc_security_group_ids = [
    "${aws_security_group.ucp.id}",
  ]
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  tags = {
    Name = "${var.env_name}-ucp-worker${count.index}"
    role = "ucp-worker"
    environment = "${var.env_name}"
  }
  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = true
  }
  ebs_block_device {
    device_name           = "/dev/sdb"
    snapshot_id           = ""
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }
}

output "ucp-worker-ip" {
    value = "${join(",", aws_instance.ucp-worker.*.public_ip)}"
}
