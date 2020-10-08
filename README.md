# ZFS-QAT-gentoo
This is an experimental repo to add Intel QuickAssist support to ZFS in gentoo. Work in progress.

# Regarding QAT driver install
Config options of the Linux Kernel:
  - CONFIG_CRYPTO_DEV_QAT=m
  - CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
  - CONFIG_CRYPTO_DEV_QAT_C3XXX=m
  - CONFIG_CRYPTO_DEV_QAT_C62X=m
  - CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
  - CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
  - CONFIG_CRYPTO_DEV_QAT_C62XVF=m.
  - CONFIG_UIO=y/m

Tested with kernel version 5.8.13.

Limitations:
  - Several sandbox violations while emerging.
  - Cannot unmerge, need to manually do make uninstall.
  - It compiles and installs the drivers for all the devices, not only the ones present in the device. Don't know if and how this can be fixed, yet.
  - At the moment it does not work with systemd.
