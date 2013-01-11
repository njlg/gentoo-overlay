# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/php-openid/php-openid-2.2.2.ebuild,v 1.2 2012/01/28 14:08:19 mabi Exp $

EAPI="3"
PHP_EXT_NAME="redis"
#USE_PHP="php5-3 php5-4"
USE_PHP="php5-4"

inherit php-ext-source-r2

MY_P="nicolasff-phpredis-2.2.1-0-g882c7dc"
MY_P2="nicolasff-phpredis-882c7dc"

DESCRIPTION="A PHP extension for Redis"
HOMEPAGE="http://github.com/nicolasff/phpredis"
SRC_URI="https://nodeload.github.com/nicolasff/phpredis/tarball/master -> ${P}.tar.gz"
DOCS="README.markdown CREDITS COPYING arrays.markdown"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tests igbinary"

#DEPEND=""
#RDEPEND="dev-lang/php"

S="${WORKDIR}/${MY_P2}"
PHP_EXT_S=${S}

#src_install() {
#	insinto "/usr/share/php/${PN}"
#	cd "${S}/Auth" && doins -r .
#
#	use examples && dodoc -r ../examples
#}
#
#pkg_postinst() {
#	elog "This ebuild can optionally make use of:"
#	elog "    dev-php/PEAR-DB"
#}
