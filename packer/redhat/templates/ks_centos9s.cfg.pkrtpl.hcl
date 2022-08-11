# KICKSTART syntax reference:
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_an_advanced_rhel_installation/kickstart-commands-and-options-reference_installing-rhel-as-an-experienced-user

# Perform the kickstart install in text mode
text

#####################
###     Common     ##
#####################

###
## Localization ##
#

# Set system keyboard type or layout
keyboard --vckeymap=gb --xlayouts='gb'

# Set language to use during installation and the default language to use on the installed system
lang en_GB.UTF-8

# Set the system time zone
timezone Europe/London --utc

###
## Software ##
#

# Installation Source
url --url="http://mirror.stream.centos.org/9-stream/BaseOS/x86_64/os"

###
## System ##
#

# Initialize the first drive
# --all             erases all partitions from the system.
# --initlabel       initializes a disk (or disks) by creating a default disk label for all disks in their respective architecture that have been designated for formatting
clearpart --all --initlabel

# Create partitions automatically
autopart

# Configure network information for target system and activate network devices in the installer environment
# --device	        device to be activated and or configured with the network command
# --onboot          enable device at a boot time.
# --bootproto       method to obtain networking configuration for device (default dhcp).
# --activate        activate this device in the installation environment.
# --noipv6	        disable IPv6 on this device.
# --hostname        host name for the installed system.
network --onboot yes --bootproto dhcp --activate --noipv6 --hostname=CentOS-Stream-9

# Configure firewall settings for the system
# --enabled         reject incoming connections that are not in response to outbound requests.
# --ssh		        allow sshd service through the firewall.
# --disabled        do not configure any iptables rules.
firewall --enabled --ssh

# State of SELinux on the installed system
# --disabled     disables SELinux completely on the system.
#selinux --disabled

# Do not configure the X Window System
skipx

###
## User Settings #
#

# Root password
rootpw ${rootpw}

# Add build user
user --groups=wheel --name=${name} --password=${password} --gecos="${name}"

###
## Installation
#

# Reboot after the installation is complete
# --eject	    attempt to eject CD or DVD media before rebooting
reboot --eject

# # Accept EULA without user interaction
eula --agreed

#####################
###    Packages    ##
#####################

%packages --ignoremissing 
@^minimal-environment
@development
python
%end

#####################
###      Post      ##
#####################

%post
# Add build user to sudoers
echo "${name}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/${name}
chmod 440 /target/etc/sudoers.d/${name}
# Update
sudo yum update -y
%end
