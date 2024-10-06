# TrueNAS

## Prerequisites

* passthrough HDD;s to vm

## Post installation setup

* Configure SMPT server
* Set email addres for user and allerts

## Troubleshooting

In case:
```shell
│   Warning  FailedMount             4m24s (x15 over 25m)  kubelet                  MountVolume.MountDevice failed for volume "pvc-2d8b3b87-e71e-4395-8129-032b806e0dd5" : rpc error: code = Internal desc = {"code":19,"stdout":"Log │
│ ging in to [iface: default, target: iqn.2005-10.org.freenas.ctl:csi-pvc-2d8b3b87-e71e-4395-8129-032b806e0dd5-cluster-home, portal: truenas.szamszur.cloud,3260]\n","stderr":"iscsiadm: Could not login to [iface: default, target:  │
│ qn.2005-10.org.freenas.ctl:csi-pvc-2d8b3b87-e71e-4395-8129-032b806e0dd5-cluster-home, portal: truenas.szamszur.cloud,3260[].\niscsiadm: initiator reported error (19 - encountered non-retryable iSCSI login failure)\niscsiadm: Co │
│ uld not log into all portals\n","timeout":false}   
```

Run on TrueNAS shell:
```shell
systemctl restart scst
```
