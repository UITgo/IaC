output "table_names" {
  value = {
    driver_locations = aws_dynamodb_table.driver_locations.name
    trip_records     = aws_dynamodb_table.trip_records.name
  }
}