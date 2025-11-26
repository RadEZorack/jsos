#!/usr/bin/env node

import { exec } from 'child_process';

// Simple proof-of-concept launcher
// Later we’ll expand this into full IPC.

console.log("J’SOS Launcher running...");

// Listen on a local port for app launch requests
import http from 'http';

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://localhost`);

  if (url.pathname === '/run') {
    const app = url.searchParams.get('app');

    if (app) {
      console.log("Launching:", app);

      // For now, only support system-level exec
      exec(app, (err) => {
        if (err) console.error("Error launching app:", err);
      });

      res.writeHead(200);
      return res.end("OK");
    }
  }

  res.writeHead(404);
  res.end("Not Found");
});

server.listen(21112, () => {
  console.log("J’SOS Launcher listening on http://127.0.0.1:21112");
});
