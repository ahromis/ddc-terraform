resource "aws_route53_zone" "ddc" {
  name = "hromis.dckr.org"
  tags {
    Environment = "${var.env_name}"
  }
}

resource "aws_route53_record" "ddc-ns" {
    zone_id = "${aws_route53_zone.ddc.zone_id}"
    name = "hromis.dckr.org"
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
  name = "${aws_elb.ucp.dns_name}"
  type = "A"
  alias {
    name = "${aws_elb.ucp.dns_name}"
    zone_id = "${aws_elb.ucp.zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dtr" {
  zone_id = "${aws_route53_zone.ddc.zone_id}"
  name = "${aws_elb.dtr.dns_name}"
  type = "A"
  alias {
    name = "${aws_elb.dtr.dns_name}"
    zone_id = "${aws_elb.dtr.zone_id}"
    evaluate_target_health = true
  }
}

#resource "aws_route53_record" "ucp" {
#   zone_id = "${var.zone_id}"
#   name = "${var.ucp_dns}"
#   type = "CNAME"
#   ttl = "300"
#   records = ["${aws_elb.ucp.dns_name}"]
#}

#resource "aws_route53_record" "dtr" {
#   zone_id = "${var.zone_id}"
#   name = "${var.dtr_dns}"
#   type = "CNAME"
#   ttl = "300"
#   records = ["${aws_elb.dtr.dns_name}"]
#}

