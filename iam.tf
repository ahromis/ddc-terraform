resource "aws_iam_instance_profile" "default" {
    name = "${var.env_name}-default"
    roles = ["${aws_iam_role.default.name}"]
}

resource "aws_iam_role_policy" "default" {
    name = "${var.env_name}-default-policy"
    role = "${aws_iam_role.default.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ec2:DescribeTags",
      "Resource": "*"
    },
      {
        "Effect": "Allow",
        "Action": [
          "s3:ListBucket",
          "s3:GetBucketLocation",
          "s3:ListBucketMultipartUploads"
        ],
        "Resource": "arn:aws:s3:::${aws_s3_bucket.dtr-bucket.id}"
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload"
        ],
        "Resource": "arn:aws:s3:::${aws_s3_bucket.dtr-bucket.id}/*"
      }
  ]
}
EOF
}

resource "aws_iam_role" "default" {
    name = "${var.env_name}-default-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
