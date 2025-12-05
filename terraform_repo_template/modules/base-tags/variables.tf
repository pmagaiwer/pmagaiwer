variable "CostString" {
  type        = string
  description = "Custos no padrão 1234.CC.123.123456"
}

variable "AppID" {
  type        = string
  description = "Identificador único da aplicação"
}

variable "AppIDs" {
  type        = list(string)
  description = "Lista de aplicações relacionadas"
  default     = []
}

variable "Environment" {
  type        = string
  description = "Ambiente da aplicação"
  validation {
    condition     = contains(["prd", "dev", "sbc", "hml", "qa"], var.Environment)
    error_message = "Environment deve ser um de: prd, dev, sbc, hml, qa."
  }
}

variable "CreatedBy" {
  type        = string
  description = "Email do criador do recurso"
}

variable "CreatedOn" {
  type        = string
  description = "Timestamp de criação"
}
