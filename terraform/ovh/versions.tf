terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "2.13.1"
    }
  }
  required_version = ">= 1.5"
}