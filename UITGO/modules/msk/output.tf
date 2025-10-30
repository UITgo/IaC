output "kafka_brokers" {
  value       = aws_msk_cluster.driver_kafka.bootstrap_brokers
  description = "List of Kafka brokers for Go service"
}
