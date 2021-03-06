resource "aws_s3_bucket" "dtr-bucket" {
    bucket = "${var.env_name}-dtr-bucket"
    acl = "private"
    tags {
        Name = "${var.env_name}-dtr-bucket"
        Environment = "${var.env_name}"
    }
}

output "s3_bucket" {
    value = "${aws_s3_bucket.dtr-bucket.id}"
}
