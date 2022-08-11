###
### Variables
###

variable "root_password" {
  description = "The password of the root account"
  type = string
  sensitive = true
  default = "packer"
}

variable "build_username" {
  description = "The username of the build account that connects via ssh"
  type = string
  sensitive = true
  default = "packer"
}

variable "build_password" {
  description = "The password of the build account that connects via ssh"
  type = string
  sensitive = true
  default = "packer"
}

# SSH

variable "ssh_pty" {
  description = "If true, a PTY will be requested for the SSH connection."
  type    = string
  default = "false"
}

variable "ssh_timeout" {
  description = "The time to wait for SSH to become available."
  type = string
  default = "30m"
}

variable "ssh_handshake_attempts" {
  description = "The number of handshakes to attempt with SSH once it can connect."
  type = number
  default = 100
}

# Build Settings
variable "cpus" {
  description = "The number of cpus to use when building the VM."
  type    = number
  default = 1
}

variable "disk_size" {
  description = "The size for the virtual disk in MB"
  type = number
  default = 40000
}

variable "firmware" {
  description = " Set the Firmware for virtual machine. Supported values: bios, efi or efi-secure."
  type = string
  default = "bios"
}

variable "memory" {
  description = " The amount of memory to use when building the VM in megabytes."
  type = number
  default = 4096
}

variable "tools_upload_flavor" {
  description = "The flavor of the VMware Tools ISO to upload into the VM."
  type = string
  default = ""
}
