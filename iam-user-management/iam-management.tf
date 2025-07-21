
resource "aws_iam_role" "admin_role" {
  name               = "admin-role"
  assume_role_policy = file("${path.module}/assume-role-policy.json")
}
resource "aws_iam_policy" "admin_policy" {
  name   = "admin-policy"
  policy = file("${path.module}/policy.json")
}
resource "aws_iam_user" "admin" {
  name = "admin-user"
  path = "/users/"
}
resource "aws_iam_user_login_profile" "console_password" {
  user                    = aws_iam_user.admin.name
  password_reset_required = true
}
resource "aws_iam_role_policy_attachment" "admin_policy_attachment" {
  role       = aws_iam_role.admin_role.name
  policy_arn = aws_iam_policy.admin_policy.arn
}
output "admin_password" {
  value = aws_iam_user_login_profile.console_password.password
  sensitive = true
}
resource "aws_iam_group" "admin" {
  name = "admin-group"
  path = "/users/"
}
# resource "aws_iam_group_policy_attachment" "admin_policy_attachment" {
#   group      = aws_iam_group.admin.name
#   policy_arn = aws_iam_policy.admin_policy.arn
# }
resource "aws_iam_group_membership" "admin_membership" {
  name  = "admin-membership"
  users = [aws_iam_user.admin.name]
  group = aws_iam_group.admin.name
}