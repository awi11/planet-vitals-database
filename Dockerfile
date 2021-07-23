FROM ubuntu:21.04

ENV NODE_ENV=production

WORKDIR /usr/src/planet-vitals-database

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
    ; \
	apt-get install -y --no-install-recommends \
		gnupg \
	;
RUN wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -