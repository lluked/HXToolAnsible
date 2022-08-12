#cloud-config
autoinstall:
    version: 1
    identity:
        hostname: ubuntu-server
        username: ${name}
        password: ${password}
    locale: en_GB
    keyboard:
        layout: gb
    user-data:
        timezone: UTC
    storage:
        layout:
            name: lvm
    ssh:
        install-server: true
        allow-pw: true
    late-commands:
        - 'echo "${name}    ALL=(ALL)    NOPASSWD: ALL" > /target/etc/sudoers.d/${name}'
        - chmod 440 /target/etc/sudoers.d/${name}
