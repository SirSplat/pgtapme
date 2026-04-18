FROM sirsplat/postgresql:latest

WORKDIR /code

COPY ./initdb.sh /docker-entrypoint-initdb.d/b_initdb.sh

USER postgres

CMD ["postgres"]
