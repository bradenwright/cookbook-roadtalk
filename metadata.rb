name             'roadtalk'
maintainer       'Braden Wright'
maintainer_email 'braden.m.wright@gmail.com'
license          'All rights reserved'
description      'Installs/Configures roadtalk'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "build-essential", '~> 2.0'
depends "apt"
depends "git"
depends "rbenv"
depends "postgresql"
depends "nginx"
depends "simple_iptables"

