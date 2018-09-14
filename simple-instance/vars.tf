variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
	default = "eu-west-1"
}

variable "AMIS" {
 type = "map"
 default = {
   eu-west-1 = "ami-0ee06eb8d6eebcde0"
   eu-west-2 = "ami-0491922b4ce27064c"
   us-west-2 = "ami-05705259d15c98ef1"
 }
}