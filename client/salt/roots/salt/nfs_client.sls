packages:
    pkg.installed:
        - pkgs:
            - nfs-common
            - portmap
            - autofs

nfs_container:
    file.directory:
        - name: {{ pillar["nfs_container"] }}
        - user: nobody
        - group: nogroup
        - makedirs: True

/etc/auto.master:
    file.append:
        - text:
            - "{{ pillar["nfs_container"] }} /etc/auto.nfs"
        - require:
            - pkg: packages

/etc/auto.nfs:
    file.managed:
        - contents: "{{ pillar["nfs_mount_name"] }}    -soft,fstype=nfs4    {{ pillar["nfs_hostname"] }}:{{ pillar["export_folder"] }}"
        - require:
            - pkg: packages

autofs:
    service:
        - running
        - enable: True
        - watch:
            - file: /etc/auto.nfs
            - file: /etc/auto.master
        - require:
            - pkg: packages