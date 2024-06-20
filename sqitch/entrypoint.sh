#!/bin/bash

# Ensure the correct permissions on .pgpass
chmod 600 /home/.pgpass

# Execute the passed command
exec "$@"