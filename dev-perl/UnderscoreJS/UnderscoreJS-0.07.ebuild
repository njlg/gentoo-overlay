# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=VTI
inherit perl-module

DESCRIPTION="Perl clone of a popular JavaScript library Underscore.js"
HOMEPAGE="http://vti.github.com/underscore-perl/"
#SRC_URI="http://github.com/vti/underscore-perl/tarball/master"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

#	dev-perl/List-Util
DEPEND="virtual/perl-Module-Build
    dev-perl/Module-Install
	dev-perl/List-MoreUtils"

src_install() {
	dodoc Changes LICENSE
}
