output "alb_controller_role_arn" {
  value = var.is_alb_controller_enabled ? aws_iam_role.alb_controller_role[0].arn : null
}