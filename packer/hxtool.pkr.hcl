## Required plugins
packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/virtualbox"
    }
    vmware = {
      version = ">= 1.0.3"
      source = "github.com/hashicorp/vmware"
    }
  }
}

## Source blocks
source "virtualbox-iso" "default" {
  cpus                   = "${var.cpus}"
  disk_size              = "${var.disk_size}"
  export_opts            = [
    "--manifest", 
    "--vsys", "0"
    ]
  format                 = "ova"
  gfx_controller         = "vmsvga"
  gfx_vram_size          = "32"
  guest_additions_path   = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type          = "Ubuntu_64"
  hard_drive_interface   = "sata"
  memory                 = "${var.memory}"
  shutdown_command       = "echo ${var.ssh_password} | sudo -S shutdown -P now"
  ssh_handshake_attempts = "${var.ssh_handshake_attempts}"
  ssh_password           = "${var.ssh_password}"
  ssh_pty                = "${var.ssh_pty}"
  ssh_timeout            = "${var.ssh_timeout}"
  ssh_username           = "${var.ssh_username}"
  vboxmanage             = [
    ["modifyvm", "{{ .Name }}", "--vrde", "off"]
  ]
}

source "vmware-iso" "default" {
  disk_size              = "${var.disk_size}"
  memory                 = "${var.memory}"
  shutdown_command       = "echo ${var.ssh_password} |sudo -S shutdown -P now"
  skip_compaction        = false
  ssh_handshake_attempts = "${var.ssh_handshake_attempts}"
  ssh_password           = "${var.ssh_password}"
  ssh_pty                = "${var.ssh_pty}"
  ssh_timeout            = "${var.ssh_timeout}"
  ssh_username           = "${var.ssh_username}"
  tools_upload_flavor    = "linux"
}

# Build
build {

  name = "roles"

  source "virtualbox-iso.default" {
    name             = "ubuntu-default"
    vm_name          = "${var.ubuntu_vm_name}_VirtualBox"
    headless         = "${var.ubuntu_headless}"
    iso_checksum     = "${var.ubuntu_iso_checksum_type}:${var.ubuntu_iso_checksum}"
    iso_urls         = ["${var.ubuntu_iso_path}/${var.ubuntu_iso_name}", "${var.ubuntu_iso_url}"]
    cd_label         = "${var.ubuntu_cd_label}"
    cd_content       = {
      "meta-data" = ""
      "user-data" = templatefile("./ubuntu/templates/user-data.pkrtpl.hcl", { interface = "enp0s3" })
    }
    boot_wait        = "${var.ubuntu_boot_wait_virtualbox}"
    boot_command     = "${var.ubuntu_boot_command}"
    output_directory = "output/${var.ubuntu_vm_name}_VirtualBox/"
  }

  source "virtualbox-iso.default" {
    name             = "redhat-default"
    vm_name          = "${var.redhat_vm_name}_VirtualBox"
    headless         = "${var.redhat_headless}"
    iso_checksum     = "${var.redhat_iso_checksum_type}:${var.redhat_iso_checksum}"
    iso_urls         = ["${var.redhat_iso_path}/${var.redhat_iso_name}", "${var.redhat_iso_url}"]
    cd_label         = "${var.redhat_cd_label}"
    cd_files         = "${var.redhat_cd_files}"
    boot_wait        = "${var.redhat_boot_wait_virtualbox}"
    boot_command     = "${var.redhat_boot_command}"
    output_directory = "output/${var.redhat_vm_name}_VirtualBox/"
  }

  source "vmware-iso.default" {
    name             = "ubuntu-default"
    vm_name          = "${var.ubuntu_vm_name}_VMWare"
    guest_os_type    = "ubuntu-64"
    headless         = "${var.ubuntu_headless}"
    iso_checksum     = "${var.ubuntu_iso_checksum_type}:${var.ubuntu_iso_checksum}"
    iso_urls         = ["${var.ubuntu_iso_path}/${var.ubuntu_iso_name}", "${var.ubuntu_iso_url}"]
    cd_label         = "${var.ubuntu_cd_label}"
    cd_content       = {
      "meta-data" = ""
      "user-data" = templatefile("templates/user-data.pkrtpl.hcl", { interface = "ens33" })
    }
    boot_wait        = "${var.ubuntu_boot_wait_vmware}"
    boot_command     = "${var.ubuntu_boot_command}"
    output_directory = "output/${var.ubuntu_vm_name}_VMWare/"
  }

  source "vmware-iso.default" {
    name             = "redhat-default"
    vm_name          = "${var.redhat_vm_name}_VMWare"
    headless         = "${var.redhat_headless}"
    iso_checksum     = "${var.redhat_iso_checksum_type}:${var.redhat_iso_checksum}"
    iso_urls         = ["${var.redhat_iso_path}/${var.redhat_iso_name}", "${var.redhat_iso_url}"]
    cd_label         = "${var.redhat_cd_label}"
    cd_files         = "${var.redhat_cd_files}"
    boot_wait        = "${var.redhat_boot_wait_virtualbox}"
    boot_command     = "${var.redhat_boot_command}"
    output_directory = "output/${var.redhat_vm_name}_VMWare/"
  }

  provisioner "ansible" {
    playbook_file = "../ansible/site.yml"
  }

  post-processor "checksum" {
    checksum_types = ["sha256"]
    output = "output/${var.ubuntu_vm_name}_virtualbox/${var.ubuntu_vm_name}.{{ .ChecksumType }}"
  }

}
