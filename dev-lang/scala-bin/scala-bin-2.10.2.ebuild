# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils

MY_P="scala-${PV}"

DESCRIPTION="The Scala Programming Language. Official binary distribution."
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="${HOMEPAGE}files/archive/${MY_P}.tgz -> ${P}.tar.gz"
LICENSE="Scala"
SLOT="$PV"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="doc examples"
# one fails with 1.7, two with 1.4 (blackdown)
#RESTRICT="test"

DEPEND="virtual/jdk:1.6
	app-arch/xz-utils"
RDEPEND=">=virtual/jre-1.6
	!dev-java/scala-bin"

S="${WORKDIR}/${MY_P}"

src_install() {
	local SCALADIR="/usr/share/${P}"

	exeinto "${SCALADIR}/bin"
	doexe $(find bin/ -type f ! -iname '*.bat')

	insinto "$SCALADIR/lib"
	doins lib/*.jar

	# man pages should have a version
	pushd man/man1
	for m in *.1; do
		newman $m `basename $m .1`-${P}.1
	done
	popd

	# docs and examples
	dodoc doc/README doc/LICENSE || die
	use doc && dohtml -r "doc/tools"

	use examples && dodoc -r examples/
}

pkg_postinst() {
	if [[ ! -n $(readlink "${ROOT}"usr/bin/scala) ]] ; then
		eselect scala set ${P}
	fi

	elog
	elog "To switch between available Scala profiles, execute as root:"
	elog "\teselect scala set (${P}, ...)"
	elog
}
