FROM sirsplat/postgresql-pgtap:latest

# Set the working directory
WORKDIR /code

# Copy initialization script
COPY ./initdb.sh ./initdb.sh

# Set the user to postgres, required to comply with scout "Default non-root User" policy
USER postgres

# Set the command to run PostgreSQL
CMD ["postgres"]