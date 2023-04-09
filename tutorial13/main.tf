terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=3.30.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

### s3
resource "aws_s3_bucket" "bucket" {
  bucket = "upload-bucket"
}

resource "aws_s3_bucket_ownership_controls" "bucketcontrol" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "this" {
  depends_on = [aws_s3_bucket_ownership_controls.bucketcontrol]
  bucket     = aws_s3_bucket.bucket.id
  acl        = "private"
}

### sqs
resource "aws_sqs_queue" "queue" {
  name                      = "upload-queue"
  delay_seconds             = 60
  max_message_size          = 8192
  message_retention_seconds = 172800
  receive_wait_time_seconds = 15
}

### s3 notification hook
data "aws_iam_policy_document" "iam_notif_policy_doc" {
  statement {
    sid = "1"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["sqs:SendMessage"]
    resources = ["arn:aws:sqs:*:*:upload-queue"]

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.bucket.arn]
    }
  }
}

### sqs policy
resource "aws_sqs_queue_policy" "notif_policy" {
  queue_url = aws_sqs_queue.queue.id
  policy    = data.aws_iam_policy_document.iam_notif_policy_doc.json
}

### bucket notification
resource "aws_s3_bucket_notification" "bucket_notif" {
  bucket = aws_s3_bucket.bucket.id

  queue {
    queue_arn = aws_sqs_queue.queue.arn
    events    = ["s3:ObjectCreated:*"]
  }
}
