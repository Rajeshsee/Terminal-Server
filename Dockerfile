# Stage 1: Java install + compile
FROM openjdk:17-jdk-slim AS java-builder
WORKDIR /app
COPY . .
# যদি Java কোড থাকে, compile করো
# RUN javac Main.java

# Stage 2: Node.js runtime
FROM node:18-slim
WORKDIR /app
COPY . .
# যদি Java builder থেকে কিছু দরকার হয়:
# COPY --from=java-builder /app/Main.class /app/

RUN npm install
CMD ["node", "server.js"]
