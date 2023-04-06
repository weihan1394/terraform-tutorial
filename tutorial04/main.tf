resource "local_file" "pet" {
  filename = var.filename
  content  = "my favourte pet is ${random_pet.my-pet.id}"
}

resource "random_pet" "my-pet" {
  prefix    = var.prefix
  separator = var.separator
  length    = var.length
}

output "pet-name" {
  value       = random_pet.my-pet.id
  description = "record the value of pet id generate by the random_pet resource"
}
