resource "local_file" "pet" {
  filename        = "C:\\Users\\weihan\\Projects\\personal\\terraform-tutorial\\tutorial01\\data\\pets.txt"
  content         = "we love pets!"
  file_permission = "0700"
}

# block_name resouurce_type resource_name {
#   arguments
#   type    = string
#   default = "value-2"
# }

# init => install the required plugins, 
# plan => , execute

# immutable infrastructure
