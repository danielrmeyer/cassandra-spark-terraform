resource "aws_instance" "cassandra_1" {
  instance_type = "m3.large"
  ami = "ami-8b392cbb" #Datastax provided AMI http://docs.datastax.com/en/cassandra/3.0/cassandra/install/installAMILaunch.html
  key_name = "${var.ssh_key_name}"
  private_ip = "172.31.32.51"
  subnet_id = "${aws_subnet.main.id}"
  vpc_security_group_ids = ["${aws_security_group.cassandra.id}"]
  depends_on = ["aws_internet_gateway.gw"]

  tags {
    Name = "${var.user_name}_cassandra_1"
  }

  provisioner "remote-exec" {
    inline = ["sudo mkdir -p /tmp/provisioning",
      "sudo chown -R ubuntu:ubuntu  /tmp/provisioning/"]
    connection {
      type = "ssh"
      user = "ubuntu"
      key_file = "${var.ssh_key_path}"
    }
  }

  provisioner "file" {
    source = "provisioning/setup.sh"
    destination = "/tmp/provisioning/setup.sh"
    connection {
      type = "ssh"
      user = "ubuntu"
      key_file = "${var.ssh_key_path}"
    }
  }

  provisioner "file" {
    source = "load_data.py"
    destination = "/tmp/provisioning/load_data.py"
    connection {
      type = "ssh"
      user = "ubuntu"
      key_file = "${var.ssh_key_path}"
    }
  }
}
