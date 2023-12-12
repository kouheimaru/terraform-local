# 引数のように使える
variable "role_name" {
  type        = string
  default     = ""
}

variable "policy_name" {
  type        = string
  default     = ""
}

variable "policy_actions" {
  type    = list(string)
  default     = [""]
}

variable "function_name" {
  type        = string
  default     = ""
}

variable "source_file" {
  type        = string
  default     = ""
}

variable "output_path" {
  type        = string
  default     = ""
}

