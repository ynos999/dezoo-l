# Use an official base image with Node 22
FROM node:22-bullseye

# Install dependencies for Hugo Extended and Go
RUN apt-get update && apt-get install -y wget git curl unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Go 1.24+
RUN wget https://dl.google.com/go/go1.24.5.linux-amd64.tar.gz \
    && tar -C /usr/local -xzf go1.24.5.linux-amd64.tar.gz \
    && rm go1.24.5.linux-amd64.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

# Install Hugo Extended v0.144+
RUN wget https://github.com/gohugoio/hugo/releases/download/v0.144.0/hugo_extended_0.144.0_Linux-64bit.tar.gz \
    && tar -xzf hugo_extended_0.144.0_Linux-64bit.tar.gz \
    && mv hugo /usr/local/bin/ \
    && rm hugo_extended_0.144.0_Linux-64bit.tar.gz

# Set working directory
WORKDIR /app

# Copy all files from current folder to container
COPY . .

# Install npm dependencies
RUN npm install

# Run project setup
RUN npm run project-setup

# Expose any necessary port (e.g., 1313 for Hugo)
EXPOSE 1313

# Default command to start the project
CMD ["npm", "run", "dev"]
# CMD ["npm", "run"]
