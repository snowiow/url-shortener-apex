resource "aws_dynamodb_table" "this" {
  name           = "Urls"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LongUrl"

  attribute {
    name = "LongUrl"
    type = "S"
  }
}
