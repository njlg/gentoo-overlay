# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
JAVA_PKG_IUSE="doc examples source"
WANT_ANT_TASKS="ant-nodeps"
CHECKREQS_MEMORY="1532M"
inherit eutils check-reqs java-pkg-2 java-ant-2 versionator

MY_PV=${PV/_p/-M}
MY_PV=${MY_PV/_rc/-RC}
MY_P="scala-${MY_PV^^}"

DESCRIPTION="The Scala Programming Language"
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="https://github.com/scala/scala/archive/v${MY_PV}.tar.gz -> ${P}-sources.tar.gz"
LICENSE="Scala"
SLOT="${P}"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
# one fails with 1.7, two with 1.4 (blackdown)
#RESTRICT="test"

DEPEND="virtual/jdk:1.6
	app-arch/xz-utils
	app-admin/eselect-scala"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}/scala-${PV}"

pkg_setup() {
	java-pkg-2_pkg_setup

	debug-print "Checking for sufficient physical RAM"

	ewarn "This package can fail to build with memory allocation errors in some cases."
	ewarn "If you are unable to build from sources, please try the scala-bin package"
	ewarn "(e.g. ${PN}-bin-${PV})"

	check-reqs_pkg_setup
}

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
		cd "${WORKDIR}"
		mv scala-${PV/_rc/-RC} ${P}
	fi
}

src_compile() {
	#unset ANT_OPTS as this is set in the build.xml
	#sets -X type variables which might come back to bite me
	unset ANT_OPTS

	# reported in bugzilla that multiple launches use less resources
	# https://bugs.gentoo.org/show_bug.cgi?id=282023
	eant all.clean
	eant -Djavac.args="-encoding UTF-8" -Djava6.home=${JAVA_HOME} -Dbuild.release=true build

	# this needs to be set before we run ant, because scaladoc doesn't fork
	export ANT_OPTS='-Xms1536M -Xmx1536M -Xss1M -XX:MaxPermSize=192M -XX:+UseParallelGC'
	eant -Dbuild.release=true dist.done
}

src_test() {
	eant test.suite || die "Some tests aren't passed"
}

src_install() {
	cd dists/latest || die

	local SCALADIR="/usr/share/${P}/"

	exeinto "${SCALADIR}bin"
	doexe $(find bin/ -type f ! -iname '*.bat')

	# sources are .scala so no use for java-pkg_dosrc
	if use source; then
		dodir "${SCALADIR}src"
		insinto "${SCALADIR}src"
		doins src/*-src.jar
	fi

	dodir "${SCALADIR}lib"
	insinto "${SCALADIR}lib"
	doins lib/*.jar

	# man pages should be postfixed with version
	pushd man/man1
	for m in *.1; do
		newman $m `basename $m .1`-${P}.1
	done
	popd

	# docs and examples
	local docdir="doc/${P}-devel-docs"
	dodoc doc/README doc/LICENSE.md doc/License.rtf ../../docs/TODO || die
	if use doc; then
		java-pkg_dojavadoc "${docdir}/api"
		dohtml -r "${docdir}/tools" || die
		docdir doc/licenses
	fi

	use examples && java-pkg_doexamples "${docdir}/examples"
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
