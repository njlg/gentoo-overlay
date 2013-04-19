# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

EAPI="5"
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
