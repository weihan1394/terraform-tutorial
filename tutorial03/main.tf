resource "local_file" "pet" {
  filename = var.filename
  content  = "test"

  # explicit dependency
  depends_on = [
    random_pet.my-pet
  ]
}

resource "random_pet" "my-pet" {
  prefix    = var.prefix
  separator = var.separator
  length    = var.length
}
