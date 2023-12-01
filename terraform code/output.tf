output "public_ip" {
  value = aws_instance.web.public_ip
}

output "public_ip_2" {
  value = aws_instance.web-2.public_ip
}
