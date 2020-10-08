# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info

DESCRIPTION="Intel(R) QuckAssist Technology driver for Linux"
HOMEPAGE="https://01.org/intel-quickassist-technology"
SRC_URI="https://01.org/sites/default/files/downloads//qat1.7.l.4.11.0-00001.tar.gz"

LICENSE="GPL-2 BSD openssl ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-libs/boost-1.14
	>=virtual/libudev-1.47"
RDEPEND=""
BDEPEND=">=sys-devel/gcc-4.4.7[cxx]
	virtual/pkgconfig"

S="${WORKDIR}"

addwrite /etc
addwrite /lib/modules
addwrite /lib/firmware
addwrite /usr/bin
addwrite /usr/lib64
addwrite /var/cache/ldconfig

src_prepare() {
	# Info on my pathces:
	# 	https://review.spdk.io/gerrit/c/spdk/spdk/+/3505/8
	# 	https://review.spdk.io/gerrit/c/spdk/spdk/+/3506/8
	# 	https://lists.yoctoproject.org/g/meta-intel/message/6451
	# 	https://www.openwall.com/lists/lkrg-users/2020/08/04/1
	#	https://patchwork.kernel.org/patch/11227775/
	#	https://github.com/torvalds/linux/blob/master/drivers/crypto/qat/qat_common/qat_algs.c
	get_version
	# Patch Kernels 5.6 and newer:
	if [[ "${KV_MAJOR}" -ge 5 ]] && [[ "${KV_MINOR}" -ge 6 ]] ; then
		eapply "${FILESDIR}"/${P}_kernel_5.6_newer_timespec_001.patch \
			"${FILESDIR}"/${P}_kernel_5.6_newer_timespec_002.patch \
			"${FILESDIR}"/${P}_kernel_5.6_newer_pci_aer_001.patch \
			"${FILESDIR}"/${P}_kernel_5.6_newer_crypto_tfm_res_bad_key_len_001.patch \
			"${FILESDIR}"/${P}_kernel_5.6_newer_ablkcipher_to_skcipher_001.patch \
			"${FILESDIR}"/${P}_kernel_5.6_newer_ablkcipher_to_skcipher_002.patch
	fi

	# Patch Kernels 5.8 and newer:
	if [[ "${KV_MAJOR}" -ge 5 ]] && [[ "${KV_MINOR}" -ge 8 ]] ; then
		eapply "${FILESDIR}"/${P}_kernel_5.8_newer_cryptohash_001.patch
	fi

	eapply_user
}

src_configure() {
	set_arch_to_kernel

	local myconf=(
		CFLAGS=${CFLAGS}
		CXXFLAGS=${CXXFLAGS}
		ICP_ROOT=${WORKDIR}
		ICP_BUILDSYSTEM_PATH=${WORKDIR}/quickassist/build_system
		ICP_BUILD_OUTPUT=${WORKDIR}/build
		ICP_ENV_DIR=${WORKDIR}/quickassist/build_system/build_files/env_files
		ICP_TOOLS_TARGET="accelcomp"
		--enable-icp-log-syslog
		--enable-qat-lkcf
		--enable-kapi
	)

	econf "${myconf[@]}"
}

src_compile() {
	default
}

src_install() {
	default
}

