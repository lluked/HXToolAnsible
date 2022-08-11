#cloud-config
autoinstall:
    version: 1
    identity:
        hostname: ubuntu-server
        username: root
        password: $6$$jPMjPR6soE6sGjVBg1uO7Vt16UCnTW/qTIfJ9eZE8bEzJk5jNNogZH/fc6RY8IoUkvecKQavwIp7a8guVhbDf/
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

    users:
    - default
    - name: ${name}
        gecos: Foo B. Bar
        primary_group: foobar
        groups: users
        passwd: $6$$jPMjPR6soE6sGjVBg1uO7Vt16UCnTW/qTIfJ9eZE8bEzJk5jNNogZH/fc6RY8IoUkvecKQavwIp7a8guVhbDf/

    late-commands:
        - 'echo "${name}    ALL=(ALL)    NOPASSWD: ALL" > /target/etc/sudoers.d/${name}'
        - chmod 440 /target/etc/sudoers.d/${name}
