resource "aws_elb" "ucp" {
    name = "${var.env_name}-ucp"
    subnets = ["${aws_subnet.public.*.id}"]
    security_groups = [
        "${aws_security_group.elb.id}",
    ]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    listener {
        instance_port = 443
        instance_protocol = "tcp"
        lb_port = 443
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "TCP:443"
        interval = 15
    }

    instances = ["${aws_instance.ucp-manager.*.id}"]
    cross_zone_load_balancing = true

    tags {
        Name = "${var.env_name}-ucp"
    }
}

resource "aws_elb" "dtr" {
    name = "${var.env_name}-dtr"
    subnets = ["${aws_subnet.public.*.id}"]
    security_groups = [
        "${aws_security_group.elb.id}",
    ]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    listener {
        instance_port = 443
        instance_protocol = "tcp"
        lb_port = 443
        lb_protocol = "tcp"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "TCP:443"
        interval = 15
    }

    instances = ["${aws_instance.ucp-worker.*.id}"]
    cross_zone_load_balancing = true

    tags {
        Name = "${var.env_name}-dtr"
    }
}
