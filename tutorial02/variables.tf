variable "filename" {
  default     = "/root/pets.txt"
  type        = string
  description = "test test"
}

variable "content" {
  default = "we love pets!"
}

variable "prefix" {
  default = ["mr", "mrs", "sir"]
  type    = list(string)
}
//var.prefix[0] = "mr"
// list(string), list(number)

variable "separator" {
  default = "."
}

variable "length" {
  default = "1"
}

variable "file-content" {
  default = {
    "statement1" = "we love pets"
    "statement2" = "we love animals"
  }
  type = map(any)
}
// var.file-content["statement2"]
// map(string)
// set(string) => must be unique

// object
variable "bella" {
  type = object({
    name         = string
    color        = string
    age          = number
    food         = list(string)
    favorite_pet = bool
  })
  default = {
    age          = 7
    color        = "brown"
    favorite_pet = true
    food         = ["fish", "chickent", "turley"]
    name         = "bella"
  }
}

// tuple
variable "kitty" {
  type = tuple([string, number, bool])
  default = [
  "cat", 1, true]
}

# terraform apply -var "filename=/root/pets.txt" -var "content=we love pets"

### export tf variable
# export TF_VAR_filename="/root/pets.txt"
# export TF_VAR_content="we love pets"

### create terraform.tfvars
# terraform.tfvars
# filename = "/root/pets.txt"
# content = "we love pets"

### variable definition precedence
# main.tf
# resource local_file_pet {
#   filename = var.filename
# }

# variable.tf
# variable filename {
# type = string
# }

# order
# 1. environment variables
# export TF_VAR_filename = "/roots/cats.txt" 

# 2. terraform.tfvars
# terraform.tfvars
# filename = "/root/pets.txt"

# 3. *.auto.tfvard (alphabetical order)
# variable.auto.tfvars
# filename = "/root/mypet.txt"

# 4. -var or -var-file (command line flags)
# terraform apply -var "filename=/root/best-pet.txt"
