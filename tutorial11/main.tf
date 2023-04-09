# terraform state

resource "local_file" "pet" {
  filename = "/Users/weihan/Project/Personal/terraform-tutorial/tutorial11/pets/txt"
  content  = "we love petsss"
}

resource "aws_dynamodb_table" "state-locking" {
  name         = "state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
# move the state without recreating the table
# terraform state mv aws_dynamodb_table.state-locking aws_dynamodb_table.state-locking-db
# rename the resource name manually from state-locking to state-locking-db

# get hashkey
# terraform state pull | jq '.resource[] | select (.name == "pet") | .instances[].attributes.hash_key'

# remove state
# terraform state rm aws_s3_bucket.finance-20232020
