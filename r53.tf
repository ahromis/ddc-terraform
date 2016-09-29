resource "aws_route53_zone" "ddc" {
  name = "${var.zone_name}"
  tags {
    Environment = "${var.env_name}"
  }
}

resource "aws_route53_record" "ddc-ns" {
    zone_id = "${var.zone_id}"
    name = "${var.zone_name}"
    type = "NS"
    ttl = "30"
    records = [
        "${aws_route53_zone.ddc.name_servers.0}",
        "${aws_route53_zone.ddc.name_servers.1}",
        "${aws_route53_zone.ddc.name_servers.2}",
        "${aws_route53_zone.ddc.name_servers.3}"
    ]
}

resource "aws_route53_record" "ucp" {
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "${var.ucp_dns}"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_elb.ucp.dns_name}"]
}

resource "aws_route53_record" "dtr" {
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "${var.dtr_dns}"
  type = "CNAME"
  ttl = "300"
  records = ["${aws_elb.dtr.dns_name}"]
}

resource "aws_route53_record" "ucp-manager" {
  count = "${var.manager_count}"
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "ucp-manager${count.index}.${var.zone_name}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.ucp-manager.*.public_ip, count.index)}"]
}

resource "aws_route53_record" "ucp-worker" {
  count = "${var.worker_count}"
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "ucp-worker${count.index}.${var.zone_name}"
  type = "A"
  ttl = "300"
  records = ["${element(aws_instance.ucp-worker.*.public_ip, count.index)}"]
}

output "ucp_manager_host_dns" {
  value = "${join(",", aws_route53_record.ucp-manager.*.name)}"
}

output "ucp_worker_host_dns" {
  value = "${join(",", aws_route53_record.ucp-worker.*.name)}"
}

output "ucp_dns" {
  value = "${var.ucp_dns}"
}

output "dtr_dns" {
  value = "${var.dtr_dns}"
}
