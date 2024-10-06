# Renaming PVE node name

This guide details the steps to rename a Proxmox VE node. **Before proceeding, ensure you have a valid backup of your Proxmox VE node.**

## 1. Change Hostname

First, change the system hostname:

```shell
hostnamectl hostname hostname_new
```

Next, update the `/etc/hosts` file to reflect the new hostname.

```shell
sed -i 's/hostname_old/hostname_new/' /etc/hosts
```

## 2. Move Configuration Files

Proxmox stores node-specific configuration in `/etc/pve/nodes`. This step moves those files to the new hostname's directory.

Backup the existing data first!

```shell
cp -R /etc/pve/nodes/hostname_old/ /root/
```

Next, move all the files and folders from the hostname_old folder to hostname_new:

```shell
mv /etc/pve/nodes/hostname_old/* /etc/pve/nodes/hostname_new/*
```

You may encounter an error like this during the move:

```shell
mv: cannot move ‘/etc/pve/nodes/hostname_old/qemu-server’ to ‘/etc/pve/nodes/hostname_new/qemu-server/
qemu-server’: Directory not empty
```

If this happens, copy the contents of the qemu-server directory recursively:

```shell
mv /etc/pve/nodes/hostname_old/qemu-server/* /etc/pve/nodes/hostname_new/qemu-server/*
```

Lastly, move the RRD database files:

```shell
mv /var/lib/rrdcached/db/pve2-node/hostname_old /var/lib/rrdcached/db/pve2-node/hostname-new
mv /var/lib/rrdcached/db/pve2-storage/hostname_old/* /var/lib/rrdcached/db/pve2-storage/hostname-new/
```

## 3. Fix the PVE Cluster Database

Renaming the node can lead to inconsistencies in the Proxmox VE cluster database (`/var/lib/pve-cluster/config.db`). You'll likely see errors like this in `journalctl -xeu pvestatd.service` or the output of `pmcxfs -d`:

```shell
Jul 08 20:01:29 <server> pmxcfs[2621]: [database] crit: found entry with duplicate name 'qemu-server' - A:(inode = 0x000000000030E094, parent = 0x000000000030E093, v./mtime = 0x30E094/0x1671282833) vs. B:(inode = 0x000000000030E64B, parent = 0x000000000030E093, v./mtime = 0x30E64B/0x1671283925)
```

This indicates a duplicate entry for `qemu-server` in the database. Here's how to resolve it:

```shell
# First backup /var/lib/pve-cluster/config.db
cp /var/lib/pve-cluster/config.db /root/config.db.bak

# Check the integrity of your sqlite db for sanity
sqlite3 /var/lib/pve-cluster/config.db 'PRAGMA integrity_check'

# Use the parent inode value in the error to check all the available entries
sqlite3 /var/lib/pve-cluster/config.db 'SELECT inode,mtime,name FROM tree WHERE parent = 0x000000000030E093'
13|1671283732|lxc
15|1671283732|openvz
16|1671283732|priv
26|1671283732|pve-ssl.key
35|1671283732|pve-ssl.pem
3203220|1671282833|qemu-server
3204683|1671283925|qemu-server
3204785|1671283996|lrm_status

# Delete the older (lower ID) qemu-server
sqlite3 /var/lib/pve-cluster/config.db 'DELETE FROM tree WHERE inode = 3203220'
```

## 4. Restart Services and verify

After making these changes, restart the Proxmox VE cluster services to apply the fixes:

```shell
systemctl restart pve-cluster
systemctl restart pvestatd.service
systemctl restart pvedaemon
systemctl restart pveproxy
```

Finally, verify that the renaming was successful:

* Check the Proxmox VE web interface. The node should now display the new hostname.
* Run pvesm status to confirm that the cluster is healthy.
* Monitor the system logs for any errors.

## Resources

* https://pve.proxmox.com/wiki/Renaming_a_PVE_node
* https://forum.proxmox.com/threads/unable-to-load-access-control-list-connection-refused.72245/
* https://forum.proxmox.com/threads/how-to-change-hostname.140236/
* https://forum.proxmox.com/threads/request-for-help-cleaning-up-my-config-db.119650/
* https://nramkumar.org/tech/blog/2023/07/08/proxmox-fixing-your-database-after-a-host-name-change/
