# 1 create vpc
# 2 create internet gateway
# 3 create a route table
# 4 create a subnet
# 5 associate a network with route table
# 6 create an sg to allow ports 22,80,443
# 7 create a network interface with an ip in the subnet that was creted in step 4
# 8 Assign an elastic ip to the network interface created in step 7
# 9 Create an aws_key_pair to acces EC2 instance from ssh
# 10 Create an ubuntu server and install/enable apache 2


# 1 create vpc
resource "aws_vpc" "prod_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Production vpc"
  }
}


# 2 create internet gateway
resource "aws_internet_gateway" "prod_gw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "Production-Internet-gw"
  }
}

# 3 create a route table
resource "aws_route_table" "prod_route_table" {
  vpc_id = aws_vpc.prod_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod_gw.id
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = aws_internet_gateway.prod_gw.id
  }

  tags = {
    Name = "Production-route-table"
  }
}

# 4 create a subnet
resource "aws_subnet" "prod_subnet" {
  vpc_id     = aws_vpc.prod_vpc.id 
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "prod-subnet"
  }
}


# 5 associate a network with route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.prod_subnet.id
  route_table_id = aws_route_table.prod_route_table.id
}


# 6 create an sg to allow ports 22,80,443
resource "aws_security_group" "allow_web_sg" {
  name        = "allow_web_traffic"
  description = "Allow web inbound traffic"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    description      = "https from my pc"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "http from my pc"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    description      = "ssh from my pc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow-connectivity-from-local-pc"
  }
}


# 7 create a network interface with an ip in the subnet that was creted in step 4
resource "aws_network_interface" "web_server_nic" {
  subnet_id       = aws_subnet.prod_subnet.id
  private_ips     = ["10.0.1.4"]
  security_groups = [aws_security_group.allow_web_sg.id]

}


# 8 Assign an elastic ip to the network interface created in step 7
resource "aws_eip" "one" {
  vpc                       = true
  network_interface         = aws_network_interface.web_server_nic.id
  associate_with_private_ip = "10.0.1.4"
  depends_on = [aws_internet_gateway.prod_gw]
}
output "server_public_ip" {
  value = aws_eip.one.public_ip
}

# 9 Create an aws_key_pair to acces EC2 instance from ssh
#   https://stackoverflow.com/questions/67389324/create-a-key-pair-and-download-the-pem-file-with-terraform-aws 
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "first-tf-project"       # Create a "first-tf-project" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create a "first-tf-project.pem" to your computer!!
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./first-tf-project.pem"
  }
}



# 10 Create an ubuntu server and install/enable apache 2
resource "aws_instance" "web_server_instance" {
  ami = "ami-04505e74c0741db8d"  # Ubuntu
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "first-tf-project"

  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.web_server_nic.id
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install apache2 -y
              sudo systemctl start apache2
              sudo bash -c 'echo your very first web server > /var/www/html/index.html'
              EOF
            
}
