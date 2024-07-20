FROM ubuntu:jammy

ARG NORM_VERSION=v3.3.51
ARG BRANCH_NAME=master

RUN \
	apt update \
	&& apt upgrade \
	&& apt-get install -y \
		gcc \
		clang \
		g++ \
		valgrind \
		git \
	&& apt-get install -y \
		curl \
		pip \
		cdist \
		python3.10-venv \
	&& bash -c "$(curl -fsSL https://raw.github.com/xicodomingues/francinette/$BRANCH_NAME/bin/install.sh)" \
	&& pip install norminette==$NORM_VERSION \
	&& apt-get purge -y \
		curl \
		pip \
		cdist \
		python3.10-venv \
	&& apt-get autoremove -y \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lits/*

WORKDIR /test
ENTRYPOINT ["bash", "/root/francinette/tester.sh"]
