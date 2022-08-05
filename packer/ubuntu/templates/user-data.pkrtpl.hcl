#cloud-config
autoinstall:
    version: 1
    identity:
        hostname: ubuntu-server
        username: packer
        password: '$6$$jPMjPR6soE6sGjVBg1uO7Vt16UCnTW/qTIfJ9eZE8bEzJk5jNNogZH/fc6RY8IoUkvecKQavwIp7a8guVhbDf/'
    keyboard:
        layout: gb
    locale: en_GB
    network:
        version: 2
        ethernets:
            ${interface}:
                dhcp4: true
                #dhcp-identifier: mac
    ssh:
        install-server: yes
        allow-pw: yes
    storage:
        layout:
            name: lvm
    late-commands:
        - 'echo "packer    ALL=(ALL)    NOPASSWD: ALL" > /target/etc/sudoers.d/packer'
        - chmod 440 /target/etc/sudoers.d/packer
