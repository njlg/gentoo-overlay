# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=PYTHIAN
MODULE_VERSION=1.46
inherit eutils perl-module

DESCRIPTION="Oracle database driver for the DBI module"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	dev-db/oracle-instantclient-basic
	dev-db/oracle-instantclient-sqlplus
	dev-perl/DBI
"
DEPEND="
	${RDEPEND}
"

LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH

perl-module_src_configure() {
	myconf="-l"
	debug-print-function $FUNCNAME "$@"
	perl-module_src_prep
}

src_prepare() {
	rm -rf README-files
}
