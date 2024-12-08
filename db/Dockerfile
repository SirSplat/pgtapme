FROM sirsplat/postgresql:latest

# Set the working directory
WORKDIR /code

# Copy initialization script
COPY ./initdb.sh /docker-entrypoint-initdb.d/b_initdb.sh

# Set the user to postgres, required to comply with scout "Default non-root User" policy
USER postgres

# Set the command to run PostgreSQL
CMD ["postgres"]