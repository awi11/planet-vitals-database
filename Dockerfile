FROM ubuntu:21.04

ENV NODE_ENV=production

WORKDIR /usr/src/planet-vitals-database

RUN mkdir -p /data/db

# 1.) sets builtin parameters for the shell. fail fast
# 2.) saves manually installed packages up to this point
# 3.) install wget, say yes, do not consider recommended packages
#     as a dependency for installing
RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \ 
	apt-get update; \
	apt-get install -y --no-install-recommends \
		wget \
        ca-certificates \
        sudo \
		gnupg \
		numactl \
    ; 
# add mongo's public key to our list of keys
RUN wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -

# add location for APT
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list

RUN apt-get update;

RUN sudo apt-get install -y mongodb-org

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

# RUN sudo systemctl start mongod
