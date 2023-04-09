terraform {
  backend "s3" {
    bucket         = "kodekloud-terraform-state-bucket02"
    key            = "finance/terraform.state"
    region         = "ap-southeast-1"
    dynamodb_table = "state-locking"
  }
}
