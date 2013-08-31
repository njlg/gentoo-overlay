# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/autojump/autojump-21.6.9.ebuild,v 1.1 2013/08/06 22:02:54 xmw Exp $

EAPI=5

DESCRIPTION="Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v."
HOMEPAGE="https://github.com/clvv/fasd"
SRC_URI="https://github.com/clvv/fasd/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Personal"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion zsh-completion"

RDEPEND="bash-completion? ( >=app-shells/bash-4 )
	zsh-completion? ( app-shells/zsh app-shells/zsh-completion )"

