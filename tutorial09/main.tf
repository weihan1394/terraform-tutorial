resource "aws_s3_bucket" "finance" {
  bucket = "finance-20232020"
  tags = {
    Description = "finance and payroll"
  }
}

resource "aws_s3_bucket_object" "finance-2020" {
  content = "/Users/weihan/Project/Personal/terraform-tutorial/tutorial09/terraform.drawio.png"
  key     = "terraform.drawio.png"
  bucket  = aws_s3_bucket.finance.id
}

resource "aws_iam_group" "finance_analysts" {
  name = "finance_analysts"
}

# read fron aws and set as data block
data "aws_iam_group" "finance-data" {
  group_name = "finance_analysts"
  depends_on = [

  ]
}

resource "aws_s3_bucket_policy" "finance-policy" {
  bucket = aws_s3_bucket.finance.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.finance.id}/*",
      "Principal": {
        "AWS": [
          "${data.aws_iam_group.finance-data.arn}"
        ]
      }
    }
  ]
}
EOF
}
