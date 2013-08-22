# NFS Server and Client with Vagrant and Salt

This repository provides Vagrantfiles and Salt states to configure both a client and server to share files across NFS.

You can also think of this as a simple resource for learning about the included technologies.

## Pre-requisites

You'll need Vagrant and VirtualBox installed. If you wish to use a different provider (such as EC2) then you may have problems with the private IP configuration we're using.

## Running the client and server

Once run, the server will export a particular shared folder across NFS. The client will be set-up to use automount to mount this directory when it is first visited.

To run:

```bash
$ cd server
$ vagrant up
$ cd ../client
$ vagrant up
```

To test things are working:

```bash
client$ touch /var/nfs_mounts/exports_from_server/hello
server$ ls -lia /data/exports  // Should list file hello, owned by nobody:nogroup
```

## Options

If you like, you can change the pillar files used by the client and server:

* export_folder: Path to the directory on the server to share out
* nfs_hostname: Hostname/IP of the NFS server
* nfs_container: On the client, path to a directory where NFS mounted directories will be added
* nfs_mount_name: On the client, the name of the directory within the container that the shared directory will be mounted to
* allowed_nfs_client_range: Instruction on which clients are allowed to connect to the NFS server. CIDR IP notation works well here (e.g. `192.168.33.0/24` allows IP addresses between `192.168.33.1` and `192.168.33.254`)
