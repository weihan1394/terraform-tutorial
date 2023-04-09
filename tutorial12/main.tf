resource "aws_instance" "webserver" {
  ami           = "ami-04ddf30efb5385f93"
  instance_type = "t2.micro"
  tags = {
    "Name"        = "webserver"
    "Description" = "An nginx server on ubuntu"
  }
  # user_data              = <<-EOF
  #   #!/bin/bash
  #   sudo apt update
  #   sudo apt install nginx -y
  #   systemctl enable nginx
  #   systemctl start nginx
  # EOF
  ### Remote Exec
  # provisioner "remote-exec" {
  #   inline = ["apt update",
  #     "apt install nginx -y",
  #     "systemctl enable nginx",
  #     "systemctl start nginx"
  #   ]
  # }
  # connection {
  #   type        = "ssh"
  #   host        = self.public_ip # translate into public ip of the instance that was provisioned
  #   user        = "ec2-user"
  #   private_key = file("/Users/weihan/.ssh/id_rsa")
  # }
  ### Local Exec
  provisioner "local-exec" {
    # on_failure = continue
    command = "echo Instance #{aws_instance.webserver.public_ip} Created! > /Users/weihan/Project/Personal/terraform-tutorial/tutorial12/data/instance_state.txt"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "echo Instance #{aws_instance.webserver.public_ip} Created! > /Users/weihan/Project/Personal/terraform-tutorial/tutorial12/data/instance_state.txt"
  }
  ### consideration
  # no way for terraform to track the provisioner in plan... if want to use nginx... should use an image with nginx installed
  key_name               = aws_key_pair.web.id
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "web" {
  public_key = file("/Users/weihan/.ssh/id_rsa.pub")
}

resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "Allow SSH access from the internet"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "publicip" {
  value = aws_instance.webserver.public_ip
}
