provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.region}"
}

resource "aws_subnet" "main" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "172.31.32.0/20"
  map_public_ip_on_launch = true
  availability_zone = "us-west-2a"
  tags {
    Name = "${var.user_name}_Main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${var.vpc_id}"
  tags {
    Name = "${var.user_name}"
  }
}


resource "aws_route_table" "r" {
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_network_acl" "main" {
  vpc_id = "${var.vpc_id}"
  subnet_ids = ["${aws_subnet.main.id}"]
  egress{
    protocol = "all"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  ingress {
    protocol = "all"
    rule_no = 1
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 0
  }

  tags {
    Name = "${var.user_name}"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_security_group" "cassandra" {
  name = "cassandra_security_group"
  description = "Security group for cassandra"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.user_name}"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    from_port = 9042
    to_port = 9042
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 9160
    to_port = 9160
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 7000
    to_port = 7000
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 7001
    to_port = 7001
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 7199
    to_port = 7199
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  #outbound internet access
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "spark" {
  name = "spark_security_group"
  description = "Security group for spark"
  vpc_id = "${var.vpc_id}"

  tags {
    Name = "${var.user_name}"
  }

  ingress {
    from_port = 4040
    to_port = 4040
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 7077
    to_port = 7077
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
