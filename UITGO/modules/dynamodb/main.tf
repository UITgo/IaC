resource "aws_dynamodb_table" "trip_records" {
  name = "${var.project_name}-trip-records"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "trip_id"
  attribute {
    name = "trip_id"
    type = "S"
  }
  
}