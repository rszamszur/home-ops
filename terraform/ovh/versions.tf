terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "2.15.0"
    }
  }
  required_version = ">= 1.5"
}