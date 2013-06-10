# Essentials
package { ['vim', 'tmux']:
    ensure  => present,
    require => Exec['apt-get update'],
}


# The Postgres repository
file { 'pgdg.list':
    name    => '/etc/apt/sources.list.d/pgdg.list',
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main'
}


#...and the required key
exec { 'pgdg key':
    command => '/usr/bin/wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -',
    unless  => '/bin/grep -c PostgreSQL /etc/apt/trusted.gpg',
}


# The Dotdeb repository for Redis
file { 'dotdeb.list':
    name    => '/etc/apt/sources.list.d/dotdeb.list',
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'deb http://mirrors.fe.up.pt/dotdeb/ wheezy all'
}


#...and the required key
exec { 'dotdeb key':
    command => '/usr/bin/wget --quiet -O - http://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -',
    unless  => '/bin/grep -c dotdeb.org /etc/apt/trusted.gpg',
}


# Update ALL the packages
exec { 'apt-get update':
   command => '/usr/bin/apt-get update',
   require => [File['pgdg.list'], Exec['pgdg key'], File['dotdeb.list'], Exec['dotdeb key']]
}


# A modern version of Postgres
package { ['postgresql-9.2', 'postgresql-client-9.2', 'build-essential', 'python-dev', 'libpq-dev', 'libevent-dev','python-setuptools']:
    ensure  => present,
    require => [File['pgdg.list'], Exec['apt-get update']]
}


# A modern version of Redis
package { ['redis-server']:
    ensure  => present,
    require => [File['dotdeb.list'], Exec['apt-get update']]
}


# The Python web stack and Postgres/Redis drivers
exec { 'python stack':
   command => '/usr/bin/easy_install gunicorn gevent psycopg2 pygments redis nose',
   require => [Exec['apt-get update'], Package['build-essential'], Package['python-setuptools'], Package['python-dev'], Package['libpq-dev'], Package['libevent-dev']],
   creates => '/usr/local/bin/gunicorn',
}
