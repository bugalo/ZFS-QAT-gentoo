# ZFS-QAT-gentoo
This is an experimental overlay to add Intel QuickAssist support to ZFS in gentoo. Work in progress.

Config options of the Linux Kernel:
  - ... as Modules.
  - ...

Tested with kernel version 5.8.13.

Limitations:
  - Several sandbox violations while emerging.
  - Cannot use --enable-icp-log-syslog yet.
  - Cannot unmerge, need to manually do make uninstall.
