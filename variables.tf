variable "region" {
  description = "Region where this module will be deployed"
  type = string
}

variable "zone_name" {
  description = "Name of the route 53 zone where all route 53 resources will be created"
  type = string
}

variable "domain_name" {
  description = "Name of the domain that will be used for these resources"
  type = string
}

variable "tags" {
  description = "Tags for all resources"
  type = object({})
}