terraform {
  required_providers {
    kafka = {
      source  = "Mongey/kafka"
      version = "~> 0.5.0"
    }
  }
}

provider "kafka" {
  bootstrap_servers = split(",", aws_msk_cluster.driver_kafka.bootstrap_brokers)
}

resource "aws_msk_cluster" "driver_kafka" {
  cluster_name = "${var.project_name}-msk-cluster"
  kafka_version = "3.5.1"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type = "kafka.m5.large"
    client_subnets = var.private_subnet_ids
    security_groups = [var.msk_sg_id]
  }

}

resource "kafka_topic" "driver_location" {
  name = "driver-location"
  partitions = 6
  replication_factor = 3
  config = {
    "cleanup.policy" = "delete"
    "segment.bytes" = "604800000"
  }
}

resource "kafka_topic" "user_location" {
  name = "user-location"
  partitions = 6
  replication_factor = 3
  config = {
    "cleanup.policy" = "delete"
    "segment.bytes" = "604800000"
  }
  
}