resource "aws_instance" "ucp-manager" {
  connection {
    user = "${var.ec2_user}"
    key_file = "${var.key_path}"
  }
  ami = "${lookup(var.ubuntu_amis, var.region)}"
  instance_type = "t2.medium"
  count = 3
  key_name = "${var.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.ucp.id}",
  ]
  subnet_id = "${aws_subnet.public.0.id}"
  tags = {
    Name = "${var.env_name}-ucp-manager-${count.index}"
    role = "ucp-manager"
    environment = "${var.env_name}"
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
  instance_type = "t2.medium"
  count = 3
  key_name = "${var.key_name}"
  vpc_security_group_ids = [
    "${aws_security_group.ucp.id}",
  ]
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  tags = {
    Name = "${var.env_name}-ucp-worker-${count.index}"
    role = "ucp-worker"
    environment = "${var.env_name}"
  }
}

output "ucp-worker-ip" {
    value = "${join(",", aws_instance.ucp-worker.*.public_ip)}"
}
