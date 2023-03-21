output "cluster_status" {
  value = data.cockroach_cluster.cockroach-cluster-data.operation_status
}

output "cert" {
  value = data.cockroach_cluster_cert.cluster-cert.cert
}

output "connection_string" {
  value = data.cockroach_connection_string.cockroach-connection-string.connection_string
}