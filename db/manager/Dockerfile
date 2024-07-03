# Stage 1: Build stage
FROM postgres:16-alpine AS build

# Install required packages and build tools
RUN apk add --no-cache --update \
    postgresql-dev postgresql-contrib git openssl build-base make perl perl-dev less wget \
    llvm15-dev clang15 \
    && rm -rf /var/cache/apk/* /tmp/*

# Install pgTAP
RUN cpan TAP::Parser::SourceHandler::pgTAP

# Clone, build, and install pgTAP
RUN git clone https://github.com/theory/pgtap.git \
    && cd pgtap \
    && make \
    && make install \
    && cd .. \
    && rm -rf pgtap

# # Clone, build, and install pg_partman from GitHub
# RUN git clone https://github.com/pgpartman/pg_partman.git \
#     && cd pg_partman \
#     && make CC=gcc \
#     && make install \
#     && cd .. \
#     && rm -rf pg_partman

# # Download, build, and install pg_cron from GitHub
# RUN git clone https://github.com/citusdata/pg_cron.git \
#     && cd pg_cron \
#     && make \
#     && make install \
#     && cd .. \
#     && rm -rf pg_cron

# Stage 2: Final stage
FROM postgres:16-alpine

# Copy installed extensions from the build stage
COPY --from=build /usr/local/lib/postgresql /usr/local/lib/postgresql
COPY --from=build /usr/local/share/postgresql/extension /usr/local/share/postgresql/extension
COPY --from=build /usr/local/bin/pg_prove /usr/local/bin/pg_prove

RUN echo "include_dir '/etc/postgresql/conf.d'" >> /usr/local/share/postgresql/postgresql.conf.sample

# Set the working directory
WORKDIR /code

# Copy initialization script (if any)
COPY ./initdb.sh /docker-entrypoint-initdb.d/.

# Set the command to run PostgreSQL
CMD ["postgres"]