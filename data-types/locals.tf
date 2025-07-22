locals {
  yaml-data = yamldecode(file("${path.module}/data.yaml"))
  role-list = distinct(flatten([for p in local.yaml-data.users : p.roles]))
  role-data = { for role in local.role-list : role => [for pair in local.yaml-data.users : pair.name if contains(pair.roles, role)] }
  user-list = distinct(flatten([for p in local.yaml-data.users : p.name]))
  user-data = { for pair in local.yaml-data.users : pair.name => pair.roles }
}
output "yaml-data" {
  value = local.yaml-data
}
output "users-data" {
  value = local.user-list
}
output "roles-data" {
  value = local.role-list
}
