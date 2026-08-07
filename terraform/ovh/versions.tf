terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "2.16.1"
    }
  }
  required_version = ">= 1.5"
}