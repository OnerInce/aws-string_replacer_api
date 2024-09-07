variable "region" {
  description = "Region to deploy whole stack"
  type        = string
}

variable "stack" {
  description = "Name of the stack to deploy"
  type        = string
}

variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}