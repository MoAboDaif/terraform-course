locals {
  tags = merge(
    var.tags,
    {
      workspace = terraform.workspace
    }
  )
}