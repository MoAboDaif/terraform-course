locals {
  yaml-data = yamldecode(file("${path.module}/data.yaml"))
  users-data = {for users in local.yaml-data.users : users.name => users.roles }
  roles-data = {for user in local.yaml-data :  user.roles => }
}
output "yaml-data" {
  value = local.yaml-data
}
output "users-data" {
  value = local.users-data
}
output "roles-data" {
  value = local.roles-data
}
