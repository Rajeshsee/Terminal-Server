// server.js (Node.js)
const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const { spawn } = require("child_process");

const app = express();
const server = http.createServer(app);
const io = new Server(server);

io.on("connection", (socket) => {
  const shell = spawn("bash");

  shell.stdout.on("data", (data) => {
    socket.emit("output", data.toString());
  });

  shell.stderr.on("data", (data) => {
    socket.emit("output", data.toString());
  });

  socket.on("input", (data) => {
    shell.stdin.write(data + "\n");
  });

  socket.on("disconnect", () => {
    shell.kill();
  });
});

server.listen(3000, () => console.log("Server running on port 3000"));
