# Rename a ZFS Data Pool in Proxmox VE

Do not use this method for your root boot pool (`rpool`), only for a standard data pool.

## Phase 1: Disconnect the Pool

1. **Stop Workloads:** Power down all Virtual Machines (VMs) and Containers (LXCs) that rely on this ZFS pool.
2. **Remove Proxmox Link:** 
   - Navigate to **Datacenter > Storage** in the Proxmox web GUI.
   - Select the storage entry associated with the pool.
   - Click **Remove** (this only detaches it from the GUI; your data remains perfectly safe).

## Phase 2: Rename via CLI

1. Open the Proxmox host shell (via SSH or the web console).
2. Execute the export and import command. It is highly recommended to run them on a single line to prevent Proxmox from automatically re-importing the old pool before you can rename it:

```bash
zpool export <old_name> && zpool import <old_name> <new_name>
```

## Phase 3: Reconnect and Update

1. **Re-add to Proxmox:**
   - Return to **Datacenter > Storage** in the web GUI.
   - Click **Add > ZFS**.
   - Set the ID to your preferred identifier and select your newly renamed pool from the **ZFS Pool** dropdown menu.
2. **Fix VM/LXC Configs (If Necessary):** 
   - If Proxmox doesn't automatically update your virtual disks, navigate to `/etc/pve/qemu-server/` (for VMs) or `/etc/pve/lxc/` (for containers).
   - Edit the relevant `.conf` configuration files to point any hardcoded storage paths from the old name to the new name. Oneliner: `grep "nmve-wd-red" /etc/pve/qemu-server/* -l | xargs sed -i 's/nmve-wd-red/nvme-wd-red/'`
3. **Start Workloads:** Turn your VMs and Containers back on.
