# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools eutils multilib prefix user

KEYWORDS="~amd64 ~x86"

SLOT="1"
DESCRIPTION="An open-source distributed database built with love."
HOMEPAGE="http://www.rethinkdb.com"
SRC_URI="http://download.rethinkdb.com/dist/${P}-1.tgz -> ${P}.tgz"
LICENSE="AGPL-3"

# need to add this for various builds:
# a. with/out tcmalloc_minimal
# b. precompiled assets?
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}
		dev-libs/protobuf
		dev-libs/protobuf-c
		dev-ruby/ruby_protobuf
		dev-util/google-perftools
		sys-libs/libunwind
		dev-lang/v8
		dev-libs/boost
		virtual/jre
		"

# and npm, less, handlebars, coffee

pkg_setup() {
	enewgroup rethinkdb 71
	enewuser rethinkdb 71 /bin/bash /var/lib/rethinkdb rethinkdb
}

src_unpack() {
	if [ "${A}" != "" ]; then
		unpack ${A}
		mv ${P}-1 $P
	fi
}

src_prepare() {
	epatch "${FILESDIR}/build-1.5.1.patch"
}

src_configure() {
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/usr/var
}

