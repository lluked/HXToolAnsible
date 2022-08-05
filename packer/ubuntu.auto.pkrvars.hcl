# Build
ubuntu_vm_name = "HXTool-Ubuntu"
// ubuntu_headless = false
ubuntu_boot_command = [
  "e<down><down><down><end>",
  " autoinstall ds=nocloud;",
  "<F10>",
]
ubuntu_boot_wait_virtualbox = "3s"
ubuntu_boot_wait_vmware = "5s"

# ISO
ubuntu_iso_name = "ubuntu-22.04-live-server-amd64.iso"
ubuntu_iso_url = "https://releases.ubuntu.com/22.04/ubuntu-22.04-live-server-amd64.iso"
ubuntu_iso_path = "./ubuntu/iso"
ubuntu_iso_checksum_type = "file"
ubuntu_iso_checksum = "https://releases.ubuntu.com/22.04/SHA256SUMS"
