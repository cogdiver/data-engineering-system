locals {
  # Components that will use IAM roles and policies
  iam_components = {
    "ui" = {
      "service": "ec2.amazonaws.com",
      "policy_statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject"
          ],
          "Resource": "*",
        }
      ]
    },
    "backend" = {
      "service": "ec2.amazonaws.com",
      "policy_statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:PutObject"
          ],
          "Resource": "*",
        }
      ]
    },
    "trigger" = {
      "service": "ec2.amazonaws.com",
      "policy_statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:DeleteObject"
          ],
          "Resource": "*",
        }
      ]
    }
  }
}
