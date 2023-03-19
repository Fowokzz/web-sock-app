variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

# variable "domain_name" {
#   type    = string
#   default = "fowokeoluwole.live"
# }

variable "domain_names" {
    type = map(string)
    description = "domain name and subdomain "
}

variable "token" {
  description = "name.com API token"
  type = string
}

variable "username" {
  description = "name.com username"
  type = string
}

variable "email_address" {
  type    = string
  default = "suliatoluwole97@gmail.com"
}


