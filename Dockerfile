# Node.js base image
FROM node:18

# Install popular interpreters and compilers
RUN apt-get update && \
    apt-get install -y \
    python3 python3-pip \
    openjdk-17-jdk \
    gcc g++ \
    php \
    ruby-full \
    perl \
    golang \
    default-mysql-client \
    sqlite3 \
    && apt-get clean

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Install Node.js dependencies
RUN npm install

# Expose port (change if needed)
EXPOSE 3000

# Run your Node.js server
CMD ["node", "server.js"]
