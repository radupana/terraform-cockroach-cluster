resource "cockroach_cluster" "cockroach-cluster" {
  name              = var.cluster_name
  cloud_provider    = var.cloud_provider
  cockroach_version = var.cockroach_version
  dedicated         = {
    storage_gib  = var.storage_gib
    machine_type = var.machine_type
  }
  regions = [
    for r in var.cloud_provider_regions : {
      name       = r,
      node_count = var.cluster_node_count
    }
  ]
}

data "cockroach_cluster_cert" "cluster-cert" {
  id = cockroach_cluster.cockroach-cluster.id
}

resource "cockroach_allow_list" "allow-list" {
  name       = var.allow_list_name
  cidr_ip    = var.cidr_ip
  cidr_mask  = var.cidr_mask
  ui         = true
  sql        = true
  cluster_id = cockroach_cluster.cockroach-cluster.id
}
terraform {
  required_providers {
    cockroach = {
      source = "cockroachdb/cockroach"
    }
  }
}

provider "cockroach" {
  apikey = var.api_key
}

resource "cockroach_sql_user" "sql-user" {
  name       = var.sql_user_name
  password   = var.sql_user_password
  cluster_id = cockroach_cluster.cockroach-cluster.id
}

resource "cockroach_database" "database" {
  name       = var.database
  cluster_id = cockroach_cluster.cockroach-cluster.id
}

data "cockroach_cluster" "cockroach-cluster-data" {
  id = cockroach_cluster.cockroach-cluster.id
}

data "cockroach_connection_string" "cockroach-connection-string" {
  id       = cockroach_cluster.cockroach-cluster.id
  sql_user = cockroach_sql_user.sql-user.name
  database = var.database

  # Caution: Including the `password` field will result in
  # the password showing up in plain text in the
  # connection string output!
  #
  # password = cockroach_sql_user.example.password

  os = var.os
}
