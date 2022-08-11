###
### Redhat Variables
###

# Build
variable "redhat_vm_name" {
  description = "This is the name of the VMX file for the new virtual machine."
  type = string
}

variable "redhat_headless" {
  description = "When this value is set to true, the machine will start without a console."
  type = bool
  default = true
}

# Boot
variable "redhat_boot_command" {
  description = "The boot_command is an array of strings. The strings are all typed in sequence."
  type = list (string)
  default = ["<tab> inst.ks=hd:/dev/sr1:/ks.cfg<enter>"]
}

variable "redhat_boot_wait_virtualbox" {
  description = "The time to wait after booting the initial virtual machine before typing the boot_command."
  type = string
  default = "5s"
}

variable "redhat_boot_wait_vmware" {
  description = "The time to wait after booting the initial virtual machine before typing the boot_command."
  type = string
  default = "5s"
}

# ISO
variable "redhat_iso_checksum" {
  description = "The checksum for the ISO file or virtual hard drive file."
  type = string
}

variable "redhat_iso_checksum_type" {
  description = "The type of checksum for the ISO file or virtual hard drive file."
  type = string
  default = "sha256"
}

variable "redhat_iso_name" {
  description = "The name of the local ISO."
  type = string
}

variable "redhat_iso_path" {
  description = "The path to a local ISO."
  type = string
  default = "iso/"
}

variable "redhat_iso_url" {
  description = "A URL to the ISO containing the installation image."
  type = string
}

# CD
variable "redhat_cd_label" {
  description = "CD Label"
  type = string
  default = "OEMDRV"
}
