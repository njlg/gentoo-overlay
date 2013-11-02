# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/scala/scala-2.9.2.ebuild,v 1.2 2012/08/20 03:00:19 ottxor Exp $

EAPI="4"
JAVA_PKG_IUSE="doc examples source"
inherit eutils java-pkg-2

MY_P="scala-${PV}"

DESCRIPTION="The Scala Programming Language. Official binary distribution."
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="${HOMEPAGE}files/archive/${MY_P}.tgz -> ${P}.tar.gz"
LICENSE="Scala"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="emacs"
# one fails with 1.7, two with 1.4 (blackdown)
#RESTRICT="test"

DEPEND="virtual/jdk:1.6
	app-arch/xz-utils"
RDEPEND=">=virtual/jre-1.6
	!dev-java/scala-bin"

PDEPEND="emacs? ( app-emacs/scala-mode )"

S="${WORKDIR}/${MY_P}"

src_install() {
	local SCALADIR="/usr/share/${PN}/"

	exeinto "${SCALADIR}/bin"
	doexe $(find bin/ -type f ! -iname '*.bat')

	# sources are .scala so no use for java-pkg_dosrc
	if use source; then
		dodir "${SCALADIR}/src"
		insinto "${SCALADIR}/src"
		doins src/*-src.jar
	fi

	java-pkg_dojar lib/*.jar

	doman man/man1/*.1 || die

	# docs and examples
	dodoc doc/README doc/LICENSE || die
	if use doc; then
		dohtml -r "doc/tools" || die
	fi

	use examples && java-pkg_doexamples "examples"

	dodir /usr/bin
	for b in $(find bin/ -type f ! -iname '*.bat'); do
		#pushd "${ED}/usr/bin" &>/dev/null
		local _name=$(basename "${b}")
		dosym "/usr/share/${JAVA_PKG_NAME}/bin/${_name}" "/usr/bin/${_name}"
		#popd &>/dev/null
	done
}
