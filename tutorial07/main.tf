resource "local_file" "pet" {
  filename = each.value
  for_each = toset(var.file)
  content  = "test"
  # count    = length(var.filename)
}
