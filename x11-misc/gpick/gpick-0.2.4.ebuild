# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit eutils autotools scons-utils

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="http://code.google.com/p/gpick/"
SRC_URI="http://gpick.googlecode.com/files/${PN}_${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="dbus debug"

RDEPEND="dev-util/scons"
DEPEND="${RDEPEND}
	>=x11-libs/gtk+-2.12
	>=dev-lib/boost-1.42
	>=dev-lang/lua-5.1
	dbus? ( sys-apps/dbus )"

S="${WORKDIR}/${PN}_${PV}"
QA_PRESTRIPPED="usr/bin/gpick"

pkg_setup() {
	tc-export AR CC CXX RANLIB

	# Make the build respect LDFLAGS.
	export LINKFLAGS="${LDFLAGS}"
}

src_install() {
	OPTS="dbus=false"
	use dbus && OPTS="dbus=true"
	use debug && OPTS="${OPTS} debug=true"

	escons ${OPTS} DESTDIR="${D}/usr" install || die
}
