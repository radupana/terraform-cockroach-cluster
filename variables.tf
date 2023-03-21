variable "api_key" {
  type      = string
  nullable  = false
  sensitive = true
}
variable "cluster_name" {
  type     = string
  nullable = false
  default  = "cockroach-cluster"
}

variable "sql_user_name" {
  type     = string
  nullable = false
  default  = "maxroach"
}

# Remember that even variables marked sensitive will show up
# in the Terraform state file. Always follow best practices
# when managing sensitive info.
# https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables#sensitive-values-in-state
variable "sql_user_password" {
  type      = string
  nullable  = false
  sensitive = true
}

variable "cockroach_version" {
  type     = string
  nullable = true
  default  = "v22.2"
}

variable "cloud_provider" {
  type     = string
  nullable = false
  default  = "GCP"
}

variable "cloud_provider_regions" {
  type     = list(string)
  nullable = false
  default  = ["europe-west2"]
}

variable "cluster_node_count" {
  type     = number
  nullable = false
  default  = 1
}

variable "storage_gib" {
  type     = number
  nullable = false
  default  = 15
}

variable "machine_type" {
  type     = string
  nullable = false
  default  = "n1-standard-2"
}

variable "allow_list_name" {
  type     = string
  nullable = false
  default  = "default-allow-list"
}

variable "os" {
  type     = string
  nullable = true
  default  = "LINUX"
}

variable "database" {
  type     = string
  nullable = false
  default  = "default-database"
}

# A production cluster should be locked down with a more
# targeted allowlist or VPC peering.
variable "cidr_ip" {
  type     = string
  nullable = false
  default  = "0.0.0.0"
}

variable "cidr_mask" {
  type     = number
  nullable = false
  default  = 0
}