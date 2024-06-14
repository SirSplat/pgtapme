FROM postgres:16-alpine

WORKDIR /code

RUN apk add --no-cache --update \
    postgresql-dev postgresql-contrib git openssl build-base make perl perl-dev less\
    && rm -rf /var/cache/apk/* /tmp/*

RUN cpan TAP::Parser::SourceHandler::pgTAP

RUN git clone https://github.com/theory/pgtap.git \
    && cd pgtap \
    && make \
    && make install \
    && cd .. \
    && rm -rf pgtap

COPY ./initdb.sh /docker-entrypoint-initdb.d/.
COPY ./dvdrental ./dvdrental

CMD ["postgres"]
