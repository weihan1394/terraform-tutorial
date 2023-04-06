resource "local_file" "pet" {
  filename        = "/root/pets.txt"
  content         = "we love pets"
  file_permission = "0700"

  lifecycle {
    # create the resource first then destroy the older
    create_before_destroy = true
    # prevent destroy of a resource
    # prevent_destroy = false
    # ignore changes to resource
    # ignore_changes = [tags, ami]
  }
}
