variable "project_id" {
  type = string
}

variable "alb_name" {
  type = string
}

variable "alb_ip_enabled" {
  type = bool
}
variable "alb_ip_name" {
  type = string
}

variable "serverless_neg" {
  type = string
}

variable "oauth2_client_id" {
  type    = string
  default = "935709849419-22tc18db4j70hd783p1c9vsm5ejmqlnl.apps.googleusercontent.com"
}

variable "oauth2_client_secret" {
  type    = string
  default = "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"
}
