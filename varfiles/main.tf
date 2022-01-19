variable "hello" {
  type    = string
  default = "Hello"
}

variable "world" {
  type    = string
  default = "World!"
}

output "hello" {
  value = "${var.hello} ${var.world}"
}
