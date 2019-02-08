FROM wordpress:5.0-php7.3-fpm

# install packages that really should just exist...
RUN apt-get update && apt-get install -y \
		git \
		wget \
		gnupg \
        vim \
        ruby-full

# how do you even build a theme without sass...
RUN gem install sass

# grab the latest composer
RUN curl https://getcomposer.org/download/$(curl -LSs https://api.github.com/repos/composer/composer/releases/latest | grep 'tag_name' | sed -e 's/.*: "//;s/".*//')/composer.phar > composer.phar \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && mkdir /var/www/.composer

# prep files needed in WP_UnitTestCase - ./bin/install-wp-tests.sh test test test developercafe_database 5.0
RUN apt-get install -y \
    subversion \
    mysql-client

# grab the latest wp-cli
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# grab the latest node and npm
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - \
    && apt-get install -y nodejs

# wrap up loose ends
RUN chown -R www-data:www-data /var/www/html /var/www/.composer \
    && apt-get autoremove -y \
    && apt-get clean