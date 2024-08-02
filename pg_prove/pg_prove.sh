#!/bin/bash

PGPROVE_IMAGE=${PGPROVE_IMAGE:=itheory/pg_prove:latest}

passenv=()

for var in \
    PGUSER PGPASSWORD PGHOST PGHOSTADDR PGPORT PGDATABASE PGSERVICE \
    PGOPTIONS PGSSLMODE PGREQUIRESSL PGSSLCOMPRESSION PGREQUIREPEER \
    PGKRBSRVNAME PGKRBSRVNAME PGGSSLIB PGCONNECT_TIMEOUT PGCLIENTENCODING \
    PGTARGETSESSIONATTRS
do
    if [ ! -z "${!var}" ]; then
       passenv+=("-e" "$var=${!var}")
    fi
done

docker run -it --rm --network host \
    --platform linux/arm64 \
    --mount "type=bind,src=$(pwd)/code/pgtapme_generated_files,dst=/repo" \
    --mount "type=bind,src=$HOME,dst=/root" \
    "${passenv[@]}" "$PGPROVE_IMAGE"  $@
