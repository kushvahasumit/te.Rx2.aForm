output "address" {
    value = "${aws_db_instance.myinstance.address}"
}

output "port" {
    value = "${aws_db_instance.myinstance.port}"
}