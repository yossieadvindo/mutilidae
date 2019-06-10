FROM debian:jessie

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    php5 \
    php5-mysql \
    php-pear \
    php5-gd \
    php5-curl \
# install tzdata package which is a dependency and set the timezone to prevent prompt$
    tzdata \
# set your timezone here
    && \
    ln -fs /usr/share/zoneinfo/Europe/London /etc/localtime \
    dpkg-reconfigure --frontend noninteractive tzdata \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY php.ini /etc/php5/apache2/php.ini
COPY mutillidae /var/www/html

RUN chown www-data:www-data -R /var/www/html && \
    rm /var/www/html/index.html

EXPOSE 80 443

COPY main.sh /
ENTRYPOINT ["/main.sh"]

