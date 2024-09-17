# Create custom IAM policies for each component
resource "aws_iam_policy" "component_policies" {
  for_each = local.iam_components

  name        = "custom-policy-${each.key}"
  path        = "/"
  description = "Policy for ${each.key} component"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = each.value.policy_statement
  })
}

# Create IAM roles for each component
resource "aws_iam_role" "component_roles" {
  for_each = local.iam_components

  name = "custom-role-${each.key}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = each.value.service
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the policy to the corresponding role
resource "aws_iam_role_policy_attachment" "attach_policies" {
  for_each = local.iam_components

  role       = aws_iam_role.component_roles[each.key].name
  policy_arn = aws_iam_policy.component_policies[each.key].arn
}
