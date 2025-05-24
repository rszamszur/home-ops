data "local_file" "startup_script" {
  filename = "${path.module}/startup.sh"
}

data "coder_parameter" "cpu" {
  name         = "cpu"
  display_name = "CPU"
  description  = "The number of CPU cores"
  default      = "2"
  icon         = "/icon/memory.svg"
  mutable      = true
  option {
    name  = "2 Cores"
    value = "2"
  }
  option {
    name  = "4 Cores"
    value = "4"
  }
  option {
    name  = "6 Cores"
    value = "6"
  }
  option {
    name  = "8 Cores"
    value = "8"
  }
  option {
    name  = "12 Cores"
    value = "12"
  }
  option {
    name  = "16 Cores"
    value = "16"
  }
}

data "coder_parameter" "memory" {
  name         = "memory"
  display_name = "Memory"
  description  = "The amount of memory in GB"
  default      = "2"
  icon         = "/icon/memory.svg"
  mutable      = true
  option {
    name  = "2 GB"
    value = "2"
  }
  option {
    name  = "4 GB"
    value = "4"
  }
  option {
    name  = "6 GB"
    value = "6"
  }
  option {
    name  = "8 GB"
    value = "8"
  }
  option {
    name  = "12 GB"
    value = "12"
  }
  option {
    name  = "16 GB"
    value = "16"
  }
}

data "coder_parameter" "storage_class" {
  name         = "storage_class"
  display_name = "StorageClass name"
  description  = "The name of the storage class to use when creating the PVC."
  default      = "pve-hddexos"
  icon         = "/emojis/1f4be.png"
  mutable      = false
  option {
    name  = "Proxmox hddexos pool"
    value = "pve-hddexos"
  }
  option {
    name  = "Proxmox nvme-pm963 pool"
    value = "pve-nvme-pm963"
  }
  option {
    name  = "Proxmox nvme-wd-blue pool"
    value = "pve-nvme-wd-blue"
  }
}

data "coder_parameter" "home_disk_size" {
  name         = "home_disk_size"
  display_name = "Home disk size"
  description  = "The size of the home disk in GB"
  default      = "30"
  type         = "number"
  icon         = "/emojis/1f4be.png"
  mutable      = false
  validation {
    min = 1
    max = 500
  }
}

data "coder_workspace" "me" {}

data "coder_workspace_owner" "me" {}
