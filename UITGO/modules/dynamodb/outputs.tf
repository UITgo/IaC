output "table_names" {
  value = {
    trip_records     = aws_dynamodb_table.trip_records.name
  }
}