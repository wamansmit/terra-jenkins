resource "aws_instance" "web" {
  ami                    = "ami-0287a05f0ef0e9d9a"      #change ami id for different region
  instance_type          = "t2.micro"
  key_name               = "Ubuntu-07"              #change key name as per your setup
  vpc_security_group_ids = [aws_security_group.Jenkins-VM-SG.id]
  user_data              = templatefile("/home/smitwaman/Documents/devops projects/a-swiggy-clone-main/terraform code/install.sh", {})

  tags = {
    Name = "Jenkins"
  }

 
}

resource "aws_instance" "web-2" {
  ami                    = "ami-0287a05f0ef0e9d9a"      #change ami id for different region
  instance_type          = "t2.small"
  key_name               = "Ubuntu-07"              #change key name as per your setup
  vpc_security_group_ids = [aws_security_group.Jenkins-VM-SG.id]
  user_data              = templatefile("/home/smitwaman/Documents/devops projects/a-swiggy-clone-main/terraform code/install.sh", {})

  tags = {
    Name = "SonarQube"
  }

}


resource "aws_security_group" "Jenkins-VM-SG" {
  name        = "Jenkins-VM-SG"
  description = "Allow TLS inbound traffic"

  ingress = [
    for port in [22, 80, 443, 8080, 9000, 3000] : {
      description      = "inbound rules"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-VM-SG"
  }
}
