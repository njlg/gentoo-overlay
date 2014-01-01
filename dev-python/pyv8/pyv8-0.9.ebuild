# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

PYTHON_DEPEND="2:2.6"

inherit eutils multilib pax-utils python subversion toolchain-funcs

DESCRIPTION="Python Wrapper for Google V8 Javascript Engine"
HOMEPAGE="http://code.google.com/p/pyv8"
ESVN_REPO_URI="http://pyv8.googlecode.com/svn/tags/${PV}"
LICENSE="Apache License 2.0"

SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-lang/v8-3.12.0
>=dev-libs/boost-1.48.0[python]
"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	ewarn "PN: ${PN}"
	ewarn "PV: ${PV}"
	subversion_src_unpack
	cd "${S}"
}

src_compile() {
	export V8_HOME=/usr
	python setup.py build
}


src_install() {
	insinto /usr
	doins -r include || die
	dodoc AUTHORS ChangeLog || die
}

