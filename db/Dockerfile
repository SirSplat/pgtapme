ARG PG_VERSION=16

# Stage 1: Build stage
FROM postgres:${PG_VERSION}-alpine AS build

RUN apk add --no-cache --update \
    postgresql-dev postgresql-contrib git openssl build-base make perl perl-dev less wget \
    llvm-dev clang \
    && rm -rf /var/cache/apk/* /tmp/*

RUN cpan TAP::Parser::SourceHandler::pgTAP

RUN git clone --depth 1 --branch v1.3.4 https://github.com/theory/pgtap.git \
    && cd pgtap \
    && make \
    && make install \
    && cd .. \
    && rm -rf pgtap

# Stage 2: Final stage
FROM postgres:${PG_VERSION}-alpine

COPY --from=build /usr/local/lib/postgresql /usr/local/lib/postgresql
COPY --from=build /usr/local/share/postgresql/extension /usr/local/share/postgresql/extension
COPY --from=build /usr/local/bin/pg_prove /usr/local/bin/pg_prove

RUN echo "include_dir '/etc/postgresql/conf.d'" >> /usr/local/share/postgresql/postgresql.conf.sample \
    && mkdir -p /etc/postgresql/conf.d

WORKDIR /code

COPY ./a_create_roles.sh /docker-entrypoint-initdb.d/a_create_roles.sh
COPY ./initdb.sh /docker-entrypoint-initdb.d/b_initdb.sh

USER postgres

CMD ["postgres"]
