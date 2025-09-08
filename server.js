const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const { spawn } = require("child_process");

const app = express();
const server = http.createServer(app);

const io = new Server(server, {
  cors: {
    origin: "*",
    methods: ["GET", "POST"]
  }
});

io.on("connection", (socket) => {
  const shell = spawn("sh"); // Render এ safe option

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

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => {
  console.log("Server running on port " + PORT);
});
