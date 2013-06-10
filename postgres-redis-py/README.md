# Postgres/Redis box

A Vagrant template to quickly set up a back-end server with modern versions of [Redis][r] and [Postgres][p], as well as a [Python][py] dev stack.

Targets:

* Debian 7

Includes:

* [Postgresql][p] 9.2 + `psycopg2`
* [Redis][r]
* Gunicorn + Gevent
* `nose`
* `pygments`

[r]: http://redis.io
[p]: http://www.postgresql.org 
[py]: http://python.org
