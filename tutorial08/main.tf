# iam policy
provider "aws" {
  region = "ap-southeast-1"
  # access_key = "XXX"
  # secret_key = "XXX"
}

resource "aws_iam_user" "admin-user" {
  name = "serene-2"
  tags = {
    "Description" = "Tehcnical team leader"
  }
}

resource "aws_iam_policy" "adminUser2" {
  name   = "AdminUsers2"
  policy = file("admin2-policy.json")
}

resource "aws_iam_user_policy_attachment" "serene2-admin-2-access" {
  user       = aws_iam_user.admin-user.name
  policy_arn = aws_iam_policy.adminUser2.arn
}
