# Install all the dependencies needed to build things.
FROM debian:stretch-slim
RUN	apt-get update \
	&& apt-get install -y \
		debhelper python3 dh-virtualenv python3-setuptools \
		python3-pip python3-dev libffi-dev argon2 fakeroot dpkg-dev \
		lsb-release python3-pymysql python3-tz python3-yaml \
		python3-passlib python3-lxml python3-iso8601 gosu gnupg2 \
		python3-virtualenv mysql-client virtualenv wget curl \
	&& curl -sL https://deb.nodesource.com/setup_8.x | bash - \
	&& apt-get update \
	&& apt-get install -y nodejs \
	&& apt-get clean \
	&& rm -fr /var/lib/apt/lists/*
