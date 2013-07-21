# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/scala/scala-2.9.2.ebuild,v 1.2 2012/08/20 03:00:19 ottxor Exp $

EAPI="5"
JAVA_PKG_IUSE="doc examples source"
WANT_ANT_TASKS="ant-nodeps"
CHECKREQS_MEMORY="1532M"
inherit eutils check-reqs java-pkg-2 java-ant-2 versionator

MY_P="${PN}-sources-${PV}"

DESCRIPTION="The Scala Programming Language"
HOMEPAGE="http://www.scala-lang.org/"
SRC_URI="${HOMEPAGE}downloads/distrib/files/${MY_P}.tgz -> ${P}.tar.gz"
LICENSE="Scala"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="emacs"
# one fails with 1.7, two with 1.4 (blackdown)
#RESTRICT="test"

DEPEND="virtual/jdk:1.6
	dev-java/ant-contrib:0
	app-arch/xz-utils"
RDEPEND=">=virtual/jre-1.6
	!dev-java/scala-bin"

PDEPEND="emacs? ( app-emacs/scala-mode )"

S="${WORKDIR}/${P}-sources"

pkg_setup() {
	java-pkg-2_pkg_setup

	debug-print "Checking for sufficient physical RAM"

	ewarn "This package can fail to build with memory allocation errors in some cases."
	ewarn "If you are unable to build from sources, please try the scala-bin package"
	ewarn "(e.g. ${PN}-bin-${PV})"

	check-reqs_pkg_setup
}

java_prepare() {
	pushd lib &> /dev/null
	# other jars are needed for bootstrap
	#rm -v jline.jar ant/ant-contrib.jar #cldcapi10.jar midpapi10.jar msil.jar *.dll || die
	rm -v ant/ant-contrib.jar || die
	java-pkg_jar-from --into ant --build-only ant-contrib
	popd &> /dev/null

	epatch "${FILESDIR}/maven-${PV}.patch"
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
	local docdir="doc/${PN}-devel-docs"
	dodoc doc/README doc/LICENSE ../../docs/TODO || die
	if use doc; then
		java-pkg_dojavadoc "${docdir}/api"
		dohtml -r "${docdir}/tools" || die
	fi

	use examples && java-pkg_doexamples "${docdir}/examples"

	dodir /usr/bin
	for b in $(find bin/ -type f ! -iname '*.bat'); do
		local _name=$(basename "${b}")
		dosym "/usr/share/${JAVA_PKG_NAME}/bin/${_name}" "/usr/bin/${_name}"
	done
}