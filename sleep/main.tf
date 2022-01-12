# Sleep some time, to simulate creating some stuff
resource "time_sleep" "wait" {
  create_duration = "60s"
}

output "hello" {
  value = "hello world"
}

