ARG PG_VERSION=16
FROM sirsplat/postgresql:latest-pg${PG_VERSION}

WORKDIR /code

COPY ./initdb.sh /docker-entrypoint-initdb.d/b_initdb.sh

USER postgres

CMD ["postgres"]
