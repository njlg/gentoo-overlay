# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=YVES
inherit perl-module

DESCRIPTION="Perl clone of a popular JavaScript library Underscore.js"
HOMEPAGE="http://vti.github.com/underscore-perl/"
SRC_URI="http://github.com/vti/underscore-perl/tarball/master"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

#	dev-perl/List-Util
DEPEND="dev-perl/Module-Install
	dev-perl/List-MoreUtils
	dev-perl/Test-Spec"

SRC_TEST=do
S=${WORKDIR}/vti-underscore-perl-7742166

src_unpack() {
	mv ${DISTDIR}/master ${DISTDIR}/${P}.tar.gz
	unpack ${P}.tar.gz
}

perl-module_src_compile() {
	elog "no compiling, son"
}

src_install() {
	dodoc README
}
