locals {
  mandatory_tags = {
    CostString = var.CostString
    AppID      = var.AppID
    AppIDs     = join(",", var.AppIDs)
    Environment = var.Environment
    CreatedBy  = var.CreatedBy
    CreatedOn  = var.CreatedOn
  }
}

output "tags" {
  value = local.mandatory_tags
}
