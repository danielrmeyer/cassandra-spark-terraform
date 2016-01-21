output "cassandra_1" {
    value = "${aws_instance.cassandra_1.public_ip}"
}
