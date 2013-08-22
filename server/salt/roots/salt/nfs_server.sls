packages:
    pkg.installed:
        - pkgs:
            - nfs-kernel-server
            - portmap

export_folder:
    file.directory:
        - name: {{ pillar["export_folder"] }}
        - user: nobody
        - group: nogroup
        - makedirs: True

/etc/exports:
    file.append:
        - text:
            - "{{ pillar["export_folder"] }} {{ pillar["allowed_nfs_client_range"] }}(rw,sync,no_subtree_check,all_squash)"
        - require:
            - pkg: packages
            - file: export_folder

Publish exports:
    cmd.wait:
        - name: exportfs -av
        - user: root
        - group: root
        - watch:
            - file: /etc/exports

nfs-kernel-server:
    service:
        - running
        - enable: True