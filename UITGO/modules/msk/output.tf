output "kafka_brokers" {
  value       = aws_msk_cluster.driver_kafka.bootstrap_brokers
  description = "List of Kafka brokers for Go service"
}

output "driver_location_topic" {
  value = kafka_topic.driver_location.name
}

output "user_location_topic" {
  value = kafka_topic.user_location.name
}
