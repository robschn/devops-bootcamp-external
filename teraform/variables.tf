
variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "gcp_region_1" {
  type        = string
  description = "GCP Region"
}

# define GCP zone
variable "gcp_zone_1" {
  type        = string
  description = "GCP Zone"
}

variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "frontendimage" {
    type = string
    description = "frontend image name"
}

variable "backendimage" {
    type = string
    description = "backend image name"
}