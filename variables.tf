variable "proyecto" {
  description = "Nombre del proyecto (ej: proyecto1)"  # ← solo es documentación
  type        = string                                         # ← define que es texto
  default     = ""
}

variable "region" {
  description = "Región de AWS donde se desplegará el proyecto"
  type        = string
  default     = "us-east-1"
}