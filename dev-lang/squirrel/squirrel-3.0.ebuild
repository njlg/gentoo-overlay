# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit autotools eutils multilib

_P="${PN}_${PV/./_}"
_P="${_P/rc/RC}"
_P="${_P}_stable"
DESCRIPTION="A interpreted language mainly used for games"
HOMEPAGE="http://squirrel-lang.org/"
# http://squirrel.googlecode.com/files/squirrel_3_0_RC1.tar.gz
# http://squirrel.googlecode.com/files/squirrel_3_0_stable.tar.gz
SRC_URI="http://${PN}.googlecode.com/files/${_P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples static-libs"

# /usr/bin/sq conflicts
RDEPEND="!app-text/ispell"

S="${WORKDIR}/SQUIRREL${PV:0:1}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-autotools.patch
	#epatch "${FILESDIR}"/${P}-supertux-const.patch
	#epatch "${FILESDIR}"/${P}-stdint.h.patch

	eautoreconf
}

src_configure() {
	econf --docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable doc) \
		$(use_enable examples) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	if ! use static-libs; then
		rm -v "${ED}"/usr/$(get_libdir)/*.la || die
	fi

	dodoc HISTORY README || die
}
