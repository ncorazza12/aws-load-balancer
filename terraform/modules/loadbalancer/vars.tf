variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "security_group_id" {}
variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "user_data_script" {}
