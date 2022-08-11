###
### Redhat Auto Variables
###

redhat_vm_name = "HXTool-RedHat"
redhat_headless = false
redhat_iso_name = "CentOS-Stream-9-x86_64-latest-boot.iso"
redhat_iso_url = "http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso"
redhat_iso_path = "./redhat/iso"
# Checksum file fails to read from repo, manually update checksum if fails
redhat_iso_checksum_type = "sha256"
redhat_iso_checksum = "cf4156d110e6a822c720bdc9e0addd18e90d0c94da302986912bed69aec4ef05"
// redhat_iso_checksum_type = "file"
// redhat_iso_checksum = "http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/iso/CentOS-Stream-9-latest-x86_64-boot.iso.SHA256SUM"
redhat_boot_wait_virtualbox = "3s"
redhat_boot_wait_vmware = "5s"
