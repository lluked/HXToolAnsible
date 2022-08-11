## Required plugins
packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.0.3"
      source = "github.com/hashicorp/virtualbox"
    }
    vmware = {
      version = ">= 1.0.7"
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
  shutdown_command       = "echo ${var.build_password} | sudo -S shutdown -P now"
  ssh_handshake_attempts = "${var.ssh_handshake_attempts}"
  ssh_password           = "${var.build_password}"
  ssh_pty                = "${var.ssh_pty}"
  ssh_timeout            = "${var.ssh_timeout}"
  ssh_username           = "${var.build_username}"
}

source "vmware-iso" "default" {
  disk_size              = "${var.disk_size}"
  memory                 = "${var.memory}"
  shutdown_command       = "echo ${var.build_password} |sudo -S shutdown -P now"
  skip_compaction        = false
  ssh_handshake_attempts = "${var.ssh_handshake_attempts}"
  ssh_password           = "${var.build_password}"
  ssh_pty                = "${var.ssh_pty}"
  ssh_timeout            = "${var.ssh_timeout}"
  ssh_username           = "${var.build_username}"
  tools_upload_flavor    = "linux"
}

# Build
build {

  name = "virtualbox"

  source "virtualbox-iso.default" {
    name             = "ubuntu"
    vm_name          = "${var.ubuntu_vm_name}_VirtualBox"
    headless         = "${var.ubuntu_headless}"
    iso_checksum     = "${var.ubuntu_iso_checksum_type}:${var.ubuntu_iso_checksum}"
    iso_urls         = ["${var.ubuntu_iso_path}/${var.ubuntu_iso_name}", "${var.ubuntu_iso_url}"]
    cd_label         = "${var.ubuntu_cd_label}"
    cd_content       = {
      "meta-data" = ""
      "user-data" = templatefile("./ubuntu/templates/user-data.pkrtpl.hcl", { interface = "enp0s3", name="${var.build_username}" })
    }
    boot_wait        = "${var.ubuntu_boot_wait_virtualbox}"
    boot_command     = "${var.ubuntu_boot_command}"
    vboxmanage       = [
      ["modifyvm", "{{ .Name }}", "--vrde", "off"],
      [ "modifyvm", "{{.Name}}", "--natpf1", "guest_ssh,tcp,,8081,,8080" ]
    ]
    output_directory = "output/${var.ubuntu_vm_name}_VirtualBox/"
  }

  source "virtualbox-iso.default" {
    name             = "redhat"
    vm_name          = "${var.redhat_vm_name}_VirtualBox"
    headless         = "${var.redhat_headless}"
    iso_checksum     = "${var.redhat_iso_checksum_type}:${var.redhat_iso_checksum}"
    iso_urls         = ["${var.redhat_iso_path}/${var.redhat_iso_name}", "${var.redhat_iso_url}"]
    cd_label         = "${var.redhat_cd_label}"
    cd_content       = {
      "ks.cfg" = templatefile("./redhat/templates/ks_centos9s.cfg.pkrtpl.hcl", { rootpw="${var.root_password}", name="${var.build_username}", password="${var.build_password}" })
    }
    boot_wait        = "${var.redhat_boot_wait_virtualbox}"
    boot_command     = "${var.redhat_boot_command}"
    vboxmanage       = [
      ["modifyvm", "{{ .Name }}", "--vrde", "off"],
      [ "modifyvm", "{{.Name}}", "--natpf1", "guest_ssh,tcp,,8082,,8080" ]
    ]
    output_directory = "output/${var.redhat_vm_name}_VirtualBox/"
  }

  provisioner "ansible" {
    playbook_file = "../ansible/site.yml"
  }

}

build {

  name = "vmware-iso"

  source "vmware-iso.default" {
    name             = "ubuntu"
    vm_name          = "${var.ubuntu_vm_name}_VMWare"
    guest_os_type    = "ubuntu-64"
    headless         = "${var.ubuntu_headless}"
    iso_checksum     = "${var.ubuntu_iso_checksum_type}:${var.ubuntu_iso_checksum}"
    iso_urls         = ["${var.ubuntu_iso_path}/${var.ubuntu_iso_name}", "${var.ubuntu_iso_url}"]
    cd_label         = "${var.ubuntu_cd_label}"
    cd_content       = {
      "meta-data" = ""
      "user-data" = templatefile("ubuntu/templates/user-data.pkrtpl.hcl", { interface = "ens33", name="${var.build_username}" })
    }
    boot_wait        = "${var.ubuntu_boot_wait_vmware}"
    boot_command     = "${var.ubuntu_boot_command}"
    output_directory = "output/${var.ubuntu_vm_name}_VMWare/"
  }

  source "vmware-iso.default" {
    name             = "redhat"
    vm_name          = "${var.redhat_vm_name}_VMWare"
    headless         = "${var.redhat_headless}"
    iso_checksum     = "${var.redhat_iso_checksum_type}:${var.redhat_iso_checksum}"
    iso_urls         = ["${var.redhat_iso_path}/${var.redhat_iso_name}", "${var.redhat_iso_url}"]
    cd_label         = "${var.redhat_cd_label}"
    cd_content       = {
      "ks.cfg" = templatefile("./redhat/templates/ks_centos9s.cfg.pkrtpl.hcl", { rootpw="${var.root_password}", name="${var.build_username}", password="${var.build_password}" })
    }
    boot_wait        = "${var.redhat_boot_wait_virtualbox}"
    boot_command     = "${var.redhat_boot_command}"
    output_directory = "output/${var.redhat_vm_name}_VMWare/"
  }

  provisioner "ansible" {
    playbook_file = "../ansible/site.yml"
  }

}
