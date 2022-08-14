resource "aws_backup_vault" "backup-vault" {
  name = "backup-sandbox"
}

resource "aws_backup_plan" "backup-plan" {
  name = "backup_plan-sandbox"
  rule {
    rule_name         = "backup_rule-sandbox"
    schedule          = "cron(0 12 * * ? *)"
    target_vault_name = aws_backup_vault.backup-vault.name
    lifecycle {
      delete_after = "1"
    }
  }
}

resource "aws_iam_role" "backup-role" {
  name               = "backup_role-sandbox"
  assume_role_policy = file("./Monitoring-Policies/backup-plan-policy.json")
}
resource "aws_iam_role_policy_attachment" "backup-role-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
  role       = aws_iam_role.backup-role.name
}

resource "aws_backup_selection" "backup-selection" {
  iam_role_arn = aws_iam_role.backup-role.arn
  name         = "backup_selection-sandbox"
  plan_id      = aws_backup_plan.backup-plan.id
  selection_tag {
    key   = "ASG"
    type  = "STRINGEQUALS"
    value = "true"
  }
}