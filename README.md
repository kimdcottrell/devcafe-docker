# LocalDev

This project combines:

* WordPress 5
  - PHP7.2
  - MySQL 8
* [WP-CLI 2](https://developer.wordpress.org/cli/commands/)
  - With `wp shell` integrated with [PsySH](https://psysh.org/)
* Integration with the [WordPress testing suite](https://developer.wordpress.org/cli/commands/scaffold/plugin-tests/)
  - Powered by [PHPUnit 6](https://phpunit.de/getting-started/phpunit-6.html)
* [Composer](https://getcomposer.org/)
* [NPM](https://www.npmjs.com/)
* [Sass](https://sass-lang.com/)

Taking your local development up to 11. 

# Requirements

- Git
- Docker 

# Pre-Setup

This container setup requires `nginx-proxy`. Start it like so:

```
# create the network
docker create network nginx-proxy

# run the nginx-proxy container on that network 
docker run --network=nginx-proxy -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy
```

If you'd rather create your own `docker-compose.yml` for this part, follow the instructions here: https://github.com/jwilder/nginx-proxy#docker-compose

## Common Errors

`Error response from daemon: driver failed programming external connectivity on endpoint nginx-proxy: Error starting userland proxy: Bind for 0.0.0.0:80: unexpected error (Failure EADDRINUSE) Error: failed to start containers: nginx-proxy`

This means something is already using port 80 on your local machine. Check that apache or nginx isn't running. This thread goes into the technical breakdown: https://github.com/jwilder/nginx-proxy/issues/839 

# Installation

```
git clone https://github.com/kimdcottrell/devcafe-docker
mv env_template .env
```

Alter the `.env`, following the directions in the file. _This is just an example_, but your file could look like:

```
# WordPress
WORDPRESS_DEBUG=0

# Database
DB_ROOT_PASS=password
DB_USER=coffeetime
DB_PASS=password
DB_NAME=espresso_machine
DB_PORT=1337

# Webserver
LOCAL_DOMAIN=developer.cafe

# Overall
SERVICE_GROUP=developercafe
```

**NOTE:** whatever string you have for `LOCAL_DOMAIN` _must also exist in your local machine's `/etc/hosts`_. e.g.

```
$ cat /etc/hosts
127.0.0.1	developer.cafe
```

# Helpful Commands

**Install a package's suggested packages to `require-dev`:**

This assumes you're trying to install suggested packages from `symfony/console`. Change this to whatever package you want. 

`composer require --dev $(composer suggests --by-package | awk '/symfony\/console/' RS= | grep -o -P '(?<=- ).*(?=:)')`
