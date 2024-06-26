# Stage 1: Builder stage
FROM python:3.11 AS builder

# Install OS dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a user named 'vscode' with a home directory and add to sudo group
RUN useradd -ms /bin/bash -u 1000 vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the 'vscode' user
USER vscode

# Set working directory for the builder
WORKDIR /home/vscode

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code
COPY . /home/vscode/code

# Stage 2: Runtime stage for development
FROM python:3.11 AS development

# Install OS dependencies required for development
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a user named 'vscode' with a home directory and add to sudo group
RUN useradd -ms /bin/bash -u 1000 vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the 'vscode' user
USER vscode

# Copy the installed dependencies from the builder stage
COPY --from=builder /home/vscode/.local /home/vscode/.local

# Set the working directory
WORKDIR /home/vscode/code

# Add the local binary path for the user-installed packages to the PATH environment variable
ENV PATH=/home/vscode/.local/bin:$PATH

# Copy the source code for runtime (overwrites the initial copy from builder stage)
COPY . /home/vscode/code

# Command to keep the container running in dev mode
CMD ["tail", "-f", "/dev/null"]

# Stage 3: Runtime stage for production
FROM python:3.11 AS production

# Install only the essential runtime OS dependencies
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Create a user named 'vscode' with a home directory and add to sudo group
RUN useradd -ms /bin/bash -u 1000 vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the 'vscode' user
USER vscode

# Copy the installed dependencies from the builder stage
COPY --from=builder /home/vscode/.local /home/vscode/.local

# Set the working directory
WORKDIR /home/vscode/code

# Add the local binary path for the user-installed packages to the PATH environment variable
ENV PATH=/home/vscode/.local/bin:$PATH

# Copy the source code for runtime
COPY . /home/vscode/code

# Command to run the application in production
CMD ["tail", "-f", "/dev/null"]  # Replace 'app.py' with your application's entry point