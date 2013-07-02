# This installes the MS TTF fonts automatically, accepting the EULA
class msfonts {
  exec { "accept-msttcorefonts-license":
    command => "/bin/sh -c \"echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections\""
  }

  package { "ttf-mscorefonts-installer":
    ensure  => installed,
    require => Exec['accept-msttcorefonts-license']
  }
}

include msfonts

# This will also setup vnc4server as a back-end for xrdp
package { ["chromium-browser", "htop", "tmux", "openbox", "xrdp", "lxterminal", "vim", "fbpanel", "lxappearance", "bash-completion"]:
    ensure => installed,
}
