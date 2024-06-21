FROM python:3.11

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a user named 'vscode' with a home directory and add to sudo group
RUN useradd -ms /bin/bash -u 1000 vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the 'vscode' user
# USER root

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR /code

COPY ../ /code

CMD ["tail", "-f", "/dev/null"]