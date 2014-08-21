# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=SRI
MODULE_VERSION=${PV}
inherit perl-module

DESCRIPTION="Real-time web framework"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
comment() { echo ''; }
COMMON_DEPEND="
  >=dev-lang/perl-5.10.1
  virtual/perl-Compress-Raw-Zlib
  virtual/perl-Data-Dumper
  virtual/perl-Digest-MD5
  virtual/perl-Digest-SHA
  $(comment dev-perl/EV)
"
DEPEND="
  ${COMMON_DEPEND}
"
RDEPEND="
  ${COMMON_DEPEND}
"
SRC_TEST="do"
