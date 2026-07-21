variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_block_subnet" {
  description = "CIDR block for the Subnet"
  type        = string
  default     = "10.0.0.0/24"
}