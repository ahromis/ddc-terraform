resource "aws_route53_zone" "ddc" {
  name = "${var.zone_name}"
  tags {
    Environment = "${var.env_name}"
  }
}

resource "aws_route53_record" "ddc-ns" {
    zone_id = "${aws_route53_zone.ddc.zone_id}"
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
  type = "A"
  alias {
    name = "${aws_elb.ucp.dns_name}"
    zone_id = "${aws_elb.ucp.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dtr" {
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "${var.dtr_dns}"
  type = "A"
  alias {
    name = "${aws_elb.dtr.dns_name}"
    zone_id = "${aws_elb.dtr.zone_id}"
    evaluate_target_health = true
  }
}

output "ucp_dns" {
  value = "${var.ucp_dns}"
}

output "dtr_dns" {
  value = "${var.dtr_dns}"
}
